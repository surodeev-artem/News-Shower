import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:news_shower/common/ui/app_localizations_ext.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_state.dart';
import 'package:news_shower/feature/news_search/controller/model/news_search_effect.dart';
import 'package:news_shower/feature/news_search/controller/news_search_controller.dart';
import 'package:news_shower/feature/news_search/ui/components/search_app_bar.dart';
import 'package:news_shower/feature/news_search/ui/components/search_list.dart';

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
        bottom: false,
        child: ListenableBuilder(
          listenable: widget._controller,
          builder: (_, _) => CustomScrollView(
            physics: widget._controller.state.listState is NewsListStateInit
                ? const NeverScrollableScrollPhysics()
                : const ClampingScrollPhysics(),
            slivers: [
              SearchAppBar(
                isInitial:
                    widget._controller.state.listState is NewsListStateInit,
                isSearchButtonEnabled:
                    widget._controller.state.isSearchButtonEnabled,
                onSearchQueryChanged: widget._controller.onSearchQueryChanged,
                onSearchButtonPressed: widget._controller.onSearchButtonPressed,
              ),
              SearchList(
                state: widget._controller.state.listState,
                load: widget._controller.load,
                onArticlePressed: widget._controller.onArticlePressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onEffect(NewsSearchEffect effect) {
    switch (effect) {
      case NewsSearchEffectArticleUrlIsNotValid():
        if (!mounted) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(context.l10n.errorArticleUrlInvalid)),
          );
    }
  }

  @override
  void dispose() {
    _effects.cancel();
    _textEditingController.dispose();
    widget._controller.dispose();
    super.dispose();
  }
}
