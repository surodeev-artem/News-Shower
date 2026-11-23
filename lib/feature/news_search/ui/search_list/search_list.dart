import 'package:material_ui/material_ui.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_state.dart';
import 'package:news_shower/feature/news_search/ui/search_list/state/empty.dart';
import 'package:news_shower/feature/news_search/ui/search_list/state/failure.dart';
import 'package:news_shower/feature/news_search/ui/search_list/state/loading.dart';
import 'package:news_shower/feature/news_search/ui/search_list/state/success.dart';

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
    return switch (_state) {
      NewsListStateInit() => const SliverToBoxAdapter(child: SizedBox.shrink()),
      NewsListStateLoading() => const SearchListLoadingState(),
      NewsListStateEmpty() => const SearchListEmptyState(),
      NewsListStateData() => SearchListSuccessState(
        state: _state,
        onRetryPressed: _load,
        onArticlePressed: _onArticlePressed,
      ),
      NewsListStateFailure() => SearchListFailureState(
        error: _state.error,
        onRetryPressed: _load,
      ),
    };
  }
}
