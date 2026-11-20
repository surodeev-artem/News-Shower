import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_ui/material_ui.dart';
import 'package:news_shower/common/ui/app_localizations_ext.dart';
import 'package:news_shower/common/ui/shimmer_box.dart';
import 'package:news_shower/feature/news_search/controller/model/article.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_item.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_state.dart';
import 'package:news_shower/feature/news_search/ui/components/search_list_failure_item.dart';

class SearchListSuccessState extends StatefulWidget {
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
  State<SearchListSuccessState> createState() => _SearchListSuccessStateState();
}

class _SearchListSuccessStateState extends State<SearchListSuccessState>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmer;
  int _visibleShimmers = 0;

  @override
  void initState() {
    super.initState();

    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final padding = 8.0;
    final hasFooter =
        !widget._state.hasReachedEnd || widget._state.loadMoreError != null;

    return SliverPadding(
      padding: EdgeInsets.only(
        left: padding,
        top: padding,
        right: padding,
        bottom: hasFooter ? 0 : padding + bottomInset,
      ),
      sliver: SliverList.builder(
        itemCount: widget._state.items.length + (hasFooter ? 1 : 0),
        itemBuilder: (_, index) {
          if (index == widget._state.items.length) {
            final shouldLoad =
                !widget._state.hasReachedEnd &&
                !widget._state.isLoadingMore &&
                widget._state.loadMoreError == null;

            if (shouldLoad) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) widget._onRetryPressed();
              });
            }
            return _FooterItem(
              state: widget._state,
              onRetryPressed: widget._onRetryPressed,
            );
          }

          return _Item(
            item: widget._state.items[index],
            shimmer: _shimmer,
            onShimmerShown: _onShimmerShown,
            onShimmerHidden: _onShimmerHidden,
            onArticlePressed: widget._onArticlePressed,
          );
        },
      ),
    );
  }

  void _onShimmerShown() {
    _visibleShimmers++;
    if (!_shimmer.isAnimating) _shimmer.repeat();
  }

  void _onShimmerHidden() {
    _visibleShimmers--;
    if (_visibleShimmers == 0) _shimmer.stop();
  }
}

class _Item extends StatelessWidget {
  final NewsListItem _item;
  final void Function(String? url) _onArticlePressed;
  final AnimationController _shimmer;
  final VoidCallback _onShimmerShown;
  final VoidCallback _onShimmerHidden;

  const _Item({
    super.key,
    required this._item,
    required this._onArticlePressed,
    required this._shimmer,
    required this._onShimmerShown,
    required this._onShimmerHidden,
  });

  @override
  Widget build(BuildContext context) {
    return switch (_item) {
      NewsListItemDate() => _DateHeaderItem(
        key: ValueKey(_item.date),
        date: _item.date,
      ),
      NewsListItemUnknownDate() => const _UnknownDateHeaderItem(
        key: ValueKey('unknown_date'),
      ),
      NewsListItemArticle() => _ArticleItem(
        key: ValueKey(
          _item.article.url?.isNotEmpty == true
              ? _item.article.url
              : Object.hash(_item.article.title, _item.article.publishedAt),
        ),
        article: _item.article,
        onPressed: () => _onArticlePressed(_item.article.url),
        shimmer: _shimmer,
        onShimmerShown: _onShimmerShown,
        onShimmerHidden: _onShimmerHidden,
      ),
    };
  }
}

class _DateHeaderItem extends StatelessWidget {
  final DateTime _date;

  const _DateHeaderItem({super.key, required this._date});

  @override
  Widget build(BuildContext context) {
    final today = DateUtils.dateOnly(DateTime.now());
    String dateTitle = _date == today
        ? context.l10n.today
        : _date == today.subtract(const Duration(days: 1))
        ? context.l10n.yesterday
        : context.l10n.publishedAtHeader(_date);

    return Padding(
      key: key,
      padding: const EdgeInsetsGeometry.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 8,
      ),
      child: Text(dateTitle, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}

class _UnknownDateHeaderItem extends StatelessWidget {
  const _UnknownDateHeaderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: key,
      padding: const EdgeInsetsGeometry.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 8,
      ),
      child: Text(
        context.l10n.unknownDate,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}

class _ArticleItem extends StatelessWidget {
  final Article _article;
  final VoidCallback _onPressed;
  final AnimationController _shimmer;
  final VoidCallback _onShimmerShown;
  final VoidCallback _onShimmerHidden;

  const _ArticleItem({
    super.key,
    required this._article,
    required this._onPressed,
    required this._shimmer,
    required this._onShimmerShown,
    required this._onShimmerHidden,
  });

  @override
  Widget build(BuildContext context) {
    String? imageUrl = _article.urlToImage;
    String? title = _article.title;
    String? description = _article.description;
    String? source = _article.source;
    DateTime? publishedAt = _article.publishedAt;
    String? publishedAtFormatted = publishedAt != null
        ? context.l10n.publishedAt(publishedAt)
        : null;

    const imageSide = 128.0;
    const gap = 16.0;
    final hasImage = imageUrl != null && imageUrl.trim().isNotEmpty;

    final cacheSide = (imageSide * MediaQuery.devicePixelRatioOf(context))
        .round();

    return Card(
      key: key,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasImage) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl.trim(),
                    width: imageSide,
                    height: imageSide,
                    memCacheWidth: cacheSide,
                    fit: BoxFit.cover,
                    useOldImageOnUrlChange: true,
                    placeholder: (_, _) => ShimmerBox(
                      width: imageSide,
                      height: imageSide,
                      animation: _shimmer,
                      onShown: _onShimmerShown,
                      onHidden: _onShimmerHidden,
                    ),
                    errorWidget: (_, _, _) => Center(
                      child: SvgPicture.asset(
                        'assets/icon/ic_not_found.svg',
                        width: 64,
                        height: 64,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: gap),
              ],
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: hasImage ? imageSide : 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (source != null) ...[
                            Text(
                              source,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const SizedBox(height: 8),
                          ],
                          if (title != null)
                            Text(
                              title,
                              style: Theme.of(context).textTheme.titleSmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          if (description != null)
                            Text(
                              description,
                              style: Theme.of(context).textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                            ),
                        ],
                      ),
                      if (publishedAtFormatted != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          publishedAtFormatted,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterItem extends StatelessWidget {
  final NewsListStateData _state;
  final VoidCallback _onRetryPressed;

  const _FooterItem({
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
