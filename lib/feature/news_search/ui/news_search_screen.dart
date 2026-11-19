import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:news_shower/common/ui/app_localizations_ext.dart';
import 'package:news_shower/feature/news_search/controller/news_search_controller.dart';
import 'package:news_shower/feature/news_search/controller/news_search_effect.dart';
import 'package:news_shower/navigation/app_routes.dart';

class NewsSearchScreen extends StatefulWidget {
  final NewsSearchController _controller;

  const NewsSearchScreen({super.key, required this._controller});

  @override
  State<NewsSearchScreen> createState() {
    return _NewsSearchScreenState();
  }
}

class _NewsSearchScreenState extends State<NewsSearchScreen> {
  late final StreamSubscription<NewsSearchEffect> _effects;
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _effects = widget._controller.effect.listen(_onEffect);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.searchTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    labelText: context.l10n.queryPlaceholder,
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (value) =>
                      widget._controller.onSearchQueryChanged(value),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) =>
                      widget._controller.onSearchButtonPressed(value),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ListenableBuilder(
                    listenable: widget._controller,
                    builder: (_, _) => FilledButton(
                      onPressed: widget._controller.state.isSearchButtonEnabled
                          ? () {
                              widget._controller.onSearchButtonPressed(
                                _textEditingController.text,
                              );
                            }
                          : null,
                      child: Text(context.l10n.searchButton),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onEffect(NewsSearchEffect effect) {
    switch (effect) {
      case NewsSearchEffectGoToList(:final query):
        Navigator.of(context)
            .pushNamed(
              AppRoutes.newsList,
              arguments: NewsListArgs(query: query),
            )
            .then((_) {
              if (!mounted) return;
              widget._controller.onReturnedFromList();
            });
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    widget._controller.dispose();
    _effects.cancel();
    super.dispose();
  }
}
