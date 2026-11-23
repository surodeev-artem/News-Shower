import 'package:material_ui/material_ui.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_item.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_state.dart';
import 'package:news_shower/feature/news_search/ui/article/article_item.dart';
import 'package:news_shower/feature/news_search/ui/search_list/item/date_header.dart';
import 'package:news_shower/feature/news_search/ui/search_list/item/footer.dart';
import 'package:news_shower/feature/news_search/ui/search_list/item/unknown_date_header.dart';

class SearchListSuccessState extends StatelessWidget {
  final NewsListStateData _state;
  final VoidCallback _onRetryPressed;
  final void Function(String? url) _onArticlePressed;

  const SearchListSuccessState({
    super.key,
    required this._state,
    required this._onRetryPressed,
    required this._onArticlePressed,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final padding = 8.0;
    final hasFooter = !_state.hasReachedEnd || _state.loadMoreError != null;

    return SliverPadding(
      padding: EdgeInsets.only(
        left: padding,
        top: padding,
        right: padding,
        bottom: hasFooter ? 0 : padding + bottomInset,
      ),
      sliver: SliverList.builder(
        itemCount: _state.items.length + (hasFooter ? 1 : 0),
        itemBuilder: (_, index) {
          if (index == _state.items.length) {
            final shouldLoad =
                !_state.hasReachedEnd &&
                !_state.isLoadingMore &&
                _state.loadMoreError == null;

            if (shouldLoad) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) _onRetryPressed();
              });
            }

            return SearchListFooterItem(
              state: _state,
              onRetryPressed: _onRetryPressed,
            );
          }

          final item = _state.items[index];
          return switch (item) {
            NewsListItemDate() => SearchListDateHeader(
              key: ValueKey(item.date),
              date: item.date,
            ),
            NewsListItemUnknownDate() => const SearchListUnknownDateHeader(
              key: ValueKey('unknown_date'),
            ),
            NewsListItemArticle() => ArticleItem(
              key: ValueKey(
                item.article.url?.isNotEmpty == true
                    ? item.article.url
                    : Object.hash(item.article.title, item.article.publishedAt),
              ),
              article: item.article,
              onPressed: () => _onArticlePressed(item.article.url),
            ),
          };
        },
      ),
    );
  }
}
