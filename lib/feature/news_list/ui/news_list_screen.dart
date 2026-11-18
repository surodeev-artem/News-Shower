import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';
import 'package:news_shower/common/app_localizations_ext.dart';
import 'package:news_shower/common/shimmer_box.dart';
import 'package:news_shower/di/app_injector.dart';
import 'package:news_shower/feature/news_list/controller/news_list.dart';
import 'package:news_shower/feature/news_list/controller/news_list_controller.dart';
import 'package:news_shower/feature/news_list/controller/news_list_error.dart';
import 'package:news_shower/feature/news_list/controller/news_list_state.dart';
import 'package:url_launcher/url_launcher.dart';

final class NewsListScreen extends StatefulWidget {
  final String query;

  const NewsListScreen({super.key, required this.query});

  @override
  State<StatefulWidget> createState() {
    return _NewsListScreenState();
  }
}

final class _NewsListScreenState extends State<NewsListScreen>
    with SingleTickerProviderStateMixin {
  late final NewsListController _controller;
  late final AnimationController _shimmer;

  @override
  void initState() {
    super.initState();
    _controller = NewsListController(AppInjector.resolve(), widget.query);
    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: _controller,
        builder: (_, _) {
          NewsListState state = _controller.state;
          return switch (state) {
            NewsListStateLoading() => _loading(),
            NewsListStateEmpty() => _emptyList(),
            NewsListStateSuccess() => _success(newsList: state.data),
            NewsListStateFailure() => _failure(error: state.error),
          };
        },
      ),
    );
  }

  Widget _loading() {
    return SizedBox.expand(child: Center(child: CircularProgressIndicator()));
  }

  Widget _emptyList() {
    return SizedBox.expand(
      child: Center(child: Text(context.l10n.newsNotFound)),
    );
  }

  Widget _failure({required NewsListError error}) {
    return SizedBox.expand(
      child: Column(
        children: switch (error) {
          NewsListErrorRateLimited() => [
            Text(context.l10n.errorTooManyRequest),
            _retryButton(onPressed: () => _controller.load()),
          ],
          NewsListErrorApiKeyDisabled() => [
            Text(context.l10n.errorApiKeyDisabled),
          ],
          NewsListErrorApiKeyExhausted() => [
            Text(context.l10n.errorApiKeyExhausted),
          ],
          NewsListErrorApiKeyInvalid() => [
            Text(context.l10n.errorApiKeyInvalid),
          ],
          NewsListErrorApiKeyMissing() => [
            Text(context.l10n.errorApiKeyMissing),
          ],
          NewsListErrorUnexpected() => [
            Text(context.l10n.errorUnexpected),
            _retryButton(onPressed: () => _controller.load()),
          ],
        },
      ),
    );
  }

  Widget _success({required NewsList newsList}) {
    final topInset = MediaQuery.paddingOf(context).top;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return SizedBox.expand(
      child: ListView.builder(
        itemCount: newsList.news.length,
        padding: EdgeInsets.fromLTRB(8, topInset + 8, 8, bottomInset + 8),
        itemBuilder: (_, index) => _article(article: newsList.news[index]),
      ),
    );
  }

  Widget _retryButton({required VoidCallback onPressed}) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(context.l10n.errorButton),
    );
  }

  Widget _article({required Article article}) {
    String? imageUrl = article.urlToImage;
    String? title = article.title;
    String? description = article.description;
    String? source = article.source;
    DateTime? publishedAt = article.publishedAt;
    String? publishedAtFormatted = publishedAt != null
        ? context.l10n.publishedAt(publishedAt)
        : null;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openInBrowser(article.url),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              const imageSide = 128.0;
              const gap = 16.0;
              final hasImage = imageUrl != null;
              final textWidth =
                  constraints.maxWidth - (hasImage ? imageSide + gap : 0);

              final cacheSide =
                  (imageSide * MediaQuery.devicePixelRatioOf(context)).round();

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (hasImage) ...[
                      Align(
                        alignment: AlignmentGeometry.topStart,
                        child: ClipRRect(
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
                            errorWidget: (_, _, _) => SizedBox(),
                          ),
                        ),
                      ),
                      const SizedBox(width: gap),
                    ],
                    Expanded(
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
                  ],
                ),
              );
            },
          ),
        ),
      ),
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
    super.dispose();
  }
}
