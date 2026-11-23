import 'dart:math';
import 'dart:ui';

import 'package:material_ui/material_ui.dart';
import 'package:news_shower/common/ui/app_localizations_ext.dart';

class SearchAppBar extends StatefulWidget {
  final double _viewportHeight;
  final bool _isInitial;
  final bool _isSearchButtonEnabled;
  final void Function(String query) _onSearchQueryChanged;
  final void Function(String query) _onSearchButtonPressed;

  const SearchAppBar({
    super.key,
    required this._viewportHeight,
    required this._isInitial,
    required this._isSearchButtonEnabled,
    required this._onSearchQueryChanged,
    required this._onSearchButtonPressed,
  });

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar>
    with TickerProviderStateMixin {
  late final TextEditingController _textEditingController;
  late final AnimationController _appBarMove;
  late final AnimationController _hintShowing;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _appBarMove = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _hintShowing = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_appBarMove, _hintShowing]),
      builder: (_, _) {
        const controlsHeight = 72.0;
        final expandedExtent = max(widget._viewportHeight, controlsHeight);
        final hintVisibility =
            (1 - _appBarMove.value) * (1 - _hintShowing.value);
        final maxExtent = lerpDouble(
          expandedExtent,
          controlsHeight,
          _appBarMove.value,
        )!;
        return SliverPersistentHeader(
          pinned: false,
          floating: true,
          delegate: _SearchAppBarDelegate(
            minExtent: controlsHeight,
            maxExtent: maxExtent,
            hintVisibility: hintVisibility,
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
    _appBarMove.dispose();
    _hintShowing.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SearchAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget._isInitial != oldWidget._isInitial) {
      if (widget._isInitial) {
        _appBarMove.reverse();
      } else {
        _appBarMove.forward();
      }
    }

    if (widget._isInitial != oldWidget._isInitial ||
        widget._isSearchButtonEnabled != oldWidget._isSearchButtonEnabled) {
      if (widget._isInitial && !widget._isSearchButtonEnabled) {
        _hintShowing.reverse();
      } else {
        _hintShowing.forward();
      }
    }
  }
}

class _SearchAppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;
  @override
  final double maxExtent;

  final double hintVisibility;
  final TextEditingController textController;
  final bool isSearchButtonEnabled;
  final void Function(String query) onSearchQueryChanged;
  final void Function(String query) onSearchButtonPressed;

  _SearchAppBarDelegate({
    required this.minExtent,
    required this.maxExtent,
    required this.hintVisibility,
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
    const controlsHeight = 48.0;
    return SizedBox.expand(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: context.l10n.queryPlaceholder,
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
                      onSubmitted: (value) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        onSearchButtonPressed(value);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: isSearchButtonEnabled
                        ? () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            onSearchButtonPressed(textController.text);
                          }
                        : null,
                    icon: const Icon(Icons.search),
                    style: IconButton.styleFrom(
                      fixedSize: const Size.square(controlsHeight),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
              Transform.translate(
                offset: const Offset(0, controlsHeight / 2),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: Opacity(
                    opacity: hintVisibility,
                    child: Text(
                      context.l10n.searchHint,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
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
        maxExtent != oldDelegate.maxExtent ||
        hintVisibility != oldDelegate.hintVisibility;
  }
}
