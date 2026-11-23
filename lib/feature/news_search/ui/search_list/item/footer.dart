import 'package:material_ui/material_ui.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_state.dart';
import 'package:news_shower/feature/news_search/ui/search_list/item/failure_item.dart';

class SearchListFooterItem extends StatelessWidget {
  final NewsListStateData _state;
  final VoidCallback _onRetryPressed;

  const SearchListFooterItem({
    super.key,
    required this._state,
    required this._onRetryPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final loadMoreError = _state.loadMoreError;

    return Padding(
      padding: EdgeInsets.only(
        top: 16,
        bottom: 8 + bottomInset,
        left: 16,
        right: 16,
      ),
      child: _state.isLoadingMore
          ? const Center(child: CircularProgressIndicator())
          : loadMoreError != null
          ? SearchListFailureItem(
              error: loadMoreError,
              onRetryPressed: _onRetryPressed,
            )
          : const SizedBox.shrink(),
    );
  }
}
