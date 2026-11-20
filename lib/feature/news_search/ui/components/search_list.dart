import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_ui/material_ui.dart';
import 'package:news_shower/common/ui/app_localizations_ext.dart';
import 'package:news_shower/common/ui/shimmer_box.dart';
import 'package:news_shower/feature/news_search/controller/model/article.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_error.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_item.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_state.dart';

class SearchList extends StatefulWidget {
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
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList>
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
    NewsListState state = widget._state;
    return switch (state) {
      NewsListStateInit() => const SliverToBoxAdapter(child: SizedBox.shrink()),
      NewsListStateLoading() => SliverFillRemaining(
        hasScrollBody: false,
        child: _loading(),
      ),
      NewsListStateEmpty() => SliverFillRemaining(
        hasScrollBody: false,
        child: _emptyList(),
      ),
      NewsListStateData() => _success(state: state),
      NewsListStateFailure() => SliverFillRemaining(
        hasScrollBody: false,
        child: _failure(error: state.error),
      ),
    };
  }

  Widget _loading() {
    return const SizedBox.expand(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _emptyList() {
    return SizedBox.expand(
      child: Center(
        child: Text(
          context.l10n.newsNotFound,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  Widget _failure({required NewsListError error}) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsetsGeometry.all(16),
        child: Center(child: _failureItem(error: error)),
      ),
    );
  }

  Widget _failureItem({required NewsListError error}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: switch (error) {
        NewsListErrorRateLimited() => [
          Text(
            context.l10n.errorTooManyRequest,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          _retryButton(onPressed: () => widget._load()),
        ],
        NewsListErrorApiKeyDisabled() => [
          Text(
            context.l10n.errorApiKeyDisabled,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
        NewsListErrorApiKeyExhausted() => [
          Text(
            context.l10n.errorApiKeyExhausted,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
        NewsListErrorApiKeyInvalid() => [
          Text(
            context.l10n.errorApiKeyInvalid,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
        NewsListErrorApiKeyMissing() => [
          Text(
            context.l10n.errorApiKeyMissing,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
        NewsListErrorUnexpected() => [
          Text(
            context.l10n.errorUnexpected,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          _retryButton(onPressed: () => widget._load()),
        ],
        NewsListErrorMaximumResultsReached() => [
          Text(
            context.l10n.errorMaximumResultsReached,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      },
    );
  }

  Widget _success({required NewsListStateData state}) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final padding = 8.0;
    final hasFooter = !state.hasReachedEnd || state.loadMoreError != null;

    return SliverPadding(
      padding: EdgeInsets.only(
        left: padding,
        top: padding,
        right: padding,
        bottom: hasFooter ? 0 : padding + bottomInset,
      ),
      sliver: SliverList.builder(
        itemCount: state.items.length + (hasFooter ? 1 : 0),
        itemBuilder: (_, index) {
          if (index == state.items.length) {
            final shouldLoad =
                !state.hasReachedEnd &&
                !state.isLoadingMore &&
                state.loadMoreError == null;

            if (shouldLoad) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) widget._load();
              });
            }
            return _footer(state);
          }

          final item = state.items[index];

          return switch (item) {
            NewsListItemDate() => _dateHeader(
              key: ValueKey(item.date),
              date: item.date,
            ),
            NewsListItemUnknownDate() => _unknownDateHeader(
              key: const ValueKey('unknown_date'),
            ),
            NewsListItemArticle() => _article(
              key: ValueKey(
                item.article.url?.isNotEmpty == true
                    ? item.article.url
                    : Object.hash(
                        item.article.title,
                        item.article.publishedAt,
                        index,
                      ),
              ),
              article: item.article,
            ),
          };
        },
      ),
    );
  }

  Widget _retryButton({required VoidCallback onPressed}) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(context.l10n.errorButton),
    );
  }

  Widget _dateHeader({Key? key, required DateTime date}) {
    return Padding(
      key: key,
      padding: const EdgeInsetsGeometry.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 8,
      ),
      child: Text(
        _dateTitle(date),
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  Widget _unknownDateHeader({Key? key}) {
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

  Widget _article({Key? key, required Article article}) {
    String? imageUrl = article.urlToImage;
    String? title = article.title;
    String? description = article.description;
    String? source = article.source;
    DateTime? publishedAt = article.publishedAt;
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
        onTap: () => widget._onArticlePressed(article.url),
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

  Widget _footer(NewsListStateData state) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final loadMoreError = state.loadMoreError;
    return Padding(
      padding: EdgeInsets.only(
        top: 16,
        bottom: 8 + bottomInset,
        left: 16,
        right: 16,
      ),
      child: state.isLoadingMore
          ? const Center(child: CircularProgressIndicator())
          : loadMoreError != null
          ? _failureItem(error: loadMoreError)
          : const SizedBox(height: 16),
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

  String _dateTitle(DateTime date) {
    final today = DateUtils.dateOnly(DateTime.now());
    if (date == today) return context.l10n.today;
    if (date == today.subtract(const Duration(days: 1))) {
      return context.l10n.yesterday;
    }
    return context.l10n.publishedAtHeader(date); // dd.MM.yyyy
  }

  @override
  void dispose() {
    _shimmer.stop();
    super.dispose();
  }
}
