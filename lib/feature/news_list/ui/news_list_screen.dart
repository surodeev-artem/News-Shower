import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_ui/material_ui.dart';
import 'package:news_shower/common/ui/app_localizations_ext.dart';
import 'package:news_shower/common/ui/shimmer_box.dart';
import 'package:news_shower/feature/news_list/controller/model/article.dart';
import 'package:news_shower/feature/news_list/controller/news_list_controller.dart';
import 'package:news_shower/feature/news_list/controller/model/news_list_error.dart';
import 'package:news_shower/feature/news_list/controller/model/news_list_state.dart';
import 'package:url_launcher/url_launcher.dart';

final class NewsListScreen extends StatefulWidget {
  final String query;
  final NewsListController _controller;

  const NewsListScreen({
    super.key,
    required this._controller,
    required this.query,
  });

  @override
  State<NewsListScreen> createState() {
    return _NewsListScreenState();
  }
}

final class _NewsListScreenState extends State<NewsListScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmer;

  @override
  void initState() {
    super.initState();
    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.query)),
      body: ListenableBuilder(
        listenable: widget._controller,
        builder: (_, _) {
          NewsListState state = widget._controller.state;
          return switch (state) {
            NewsListStateInit() => _loading(),
            NewsListStateLoading() => _loading(),
            NewsListStateEmpty() => _emptyList(),
            NewsListStateData() => _success(state: state),
            NewsListStateFailure() => _failure(error: state.error),
          };
        },
      ),
    );
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
          _retryButton(onPressed: () => widget._controller.load()),
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
          _retryButton(onPressed: () => widget._controller.load()),
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

    return SizedBox.expand(
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (notification) {
          if (state.loadMoreError != null || state.isLoadingMore) return false;

          final metrics = notification.metrics;
          final atEnd = metrics.pixels >= metrics.maxScrollExtent;
          if (atEnd) {
            widget._controller.load();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: state.articles.length + (hasFooter ? 1 : 0),
          padding: EdgeInsets.only(
            left: padding,
            top: padding,
            right: padding,
            bottom: bottomInset + (hasFooter ? 0 : bottomInset),
          ),
          itemBuilder: (_, index) {
            if (index == state.articles.length) {
              return _footer(state);
            }

            return _article(
              key: ValueKey(
                state.articles[index].url?.isNotEmpty == true
                    ? state.articles[index].url
                    : Object.hash(
                        state.articles[index].title,
                        state.articles[index].publishedAt,
                        index,
                      ),
              ),
              article: state.articles[index],
            );
          },
        ),
      ),
    );
  }

  Widget _retryButton({required VoidCallback onPressed}) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(context.l10n.errorButton),
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

    return Card(
      key: key,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openInBrowser(article.url),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              const imageSide = 128.0;
              const gap = 16.0;
              final hasImage = imageUrl != null && imageUrl.isNotEmpty;

              final cacheSide =
                  (imageSide * MediaQuery.devicePixelRatioOf(context)).round();

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasImage) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        width: imageSide,
                        height: imageSide,
                        memCacheWidth: cacheSide,
                        fit: BoxFit.cover,
                        useOldImageOnUrlChange: true,
                        placeholder: (_, _) => ShimmerBox(
                          width: imageSide,
                          height: imageSide,
                          animation: _shimmer,
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium,
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
              );
            },
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

  Future<void> _openInBrowser(String? rawUrl) async {
    final url = rawUrl;
    if (url == null || url.isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) return;
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      return;
    }
  }

  @override
  void dispose() {
    _shimmer.stop();
    widget._controller.dispose();
    super.dispose();
  }
}
