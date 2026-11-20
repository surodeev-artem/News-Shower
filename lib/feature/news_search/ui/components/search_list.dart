import 'package:material_ui/material_ui.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_state.dart';
import 'package:news_shower/feature/news_search/ui/components/search_list_empty_state.dart';
import 'package:news_shower/feature/news_search/ui/components/search_list_failure_state.dart';
import 'package:news_shower/feature/news_search/ui/components/search_list_loading_state.dart';
import 'package:news_shower/feature/news_search/ui/components/search_list_success_state.dart';

class SearchList extends StatelessWidget {
  final NewsListState _state;
  final VoidCallback _load;
  final void Function(String? url) _onArticlePressed;

  const SearchList({
    super.key,
    required this._state,
    required this._load,
    required this._onArticlePressed,
  });

  @override
  Widget build(BuildContext context) {
    NewsListState state = _state;
    return switch (state) {
      NewsListStateInit() => const SliverToBoxAdapter(child: SizedBox.shrink()),
      NewsListStateLoading() => const SearchListLoadingState(),
      NewsListStateEmpty() => const SearchListEmptyState(),
      NewsListStateData() => SearchListSuccessState(
        state: state,
        onRetryPressed: _load,
        onArticlePressed: _onArticlePressed,
      ),
      NewsListStateFailure() => SearchListFailureState(
        error: state.error,
        onRetryPressed: _load,
      ),
    };
  }
}
