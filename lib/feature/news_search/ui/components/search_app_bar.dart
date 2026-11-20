import 'dart:ui';

import 'package:material_ui/material_ui.dart';
import 'package:news_shower/common/ui/app_localizations_ext.dart';

class SearchAppBar extends StatefulWidget {
  final bool _isInitial;
  final bool _isSearchButtonEnabled;
  final void Function(String query) _onSearchQueryChanged;
  final void Function(String query) _onSearchButtonPressed;

  const SearchAppBar({
    super.key,
    required this._isInitial,
    required this._isSearchButtonEnabled,
    required this._onSearchQueryChanged,
    required this._onSearchButtonPressed,
  });

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _textEditingController;
  late final AnimationController _move;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _move = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _move,
      builder: (_, _) {
        final controlsHeight = 72.0;
        final media = MediaQuery.of(context);
        final viewport = media.size.height - media.viewPadding.vertical;
        final maxExtent = lerpDouble(viewport, controlsHeight, _move.value)!;

        return SliverPersistentHeader(
          pinned: false,
          floating: true,
          delegate: _SearchAppBarDelegate(
            minExtent: controlsHeight,
            maxExtent: maxExtent,
            textController: _textEditingController,
            isSearchButtonEnabled: widget._isSearchButtonEnabled,
            onSearchQueryChanged: widget._onSearchQueryChanged,
            onSearchButtonPressed: widget._onSearchButtonPressed,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _move.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SearchAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._isInitial == oldWidget._isInitial) return;
    if (widget._isInitial) {
      _move.reverse();
    } else {
      _move.forward();
    }
  }
}

class _SearchAppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;
  @override
  final double maxExtent;

  final TextEditingController textController;
  final bool isSearchButtonEnabled;
  final void Function(String query) onSearchQueryChanged;
  final void Function(String query) onSearchButtonPressed;

  _SearchAppBarDelegate({
    required this.minExtent,
    required this.maxExtent,
    required this.textController,
    required this.isSearchButtonEnabled,
    required this.onSearchQueryChanged,
    required this.onSearchButtonPressed,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final controlsHeight = 48.0;
    return SizedBox.expand(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: context.l10n.queryPlaceholder,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: (minExtent - controlsHeight) / 2,
                        ),
                      ),
                      textInputAction: TextInputAction.search,
                      controller: textController,
                      onChanged: onSearchQueryChanged,
                      onSubmitted: onSearchButtonPressed,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: isSearchButtonEnabled
                        ? () => onSearchButtonPressed(textController.text)
                        : null,
                    icon: const Icon(Icons.search),
                    style: IconButton.styleFrom(
                      fixedSize: Size.square(controlsHeight),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_SearchAppBarDelegate oldDelegate) {
    return isSearchButtonEnabled != oldDelegate.isSearchButtonEnabled ||
        textController != oldDelegate.textController ||
        minExtent != oldDelegate.minExtent ||
        maxExtent != oldDelegate.maxExtent;
  }
}
