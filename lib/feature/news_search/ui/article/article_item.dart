import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_ui/material_ui.dart';
import 'package:news_shower/common/ui/app_localizations_ext.dart';
import 'package:news_shower/common/ui/shimmer_box.dart';
import 'package:news_shower/feature/news_search/controller/model/article.dart';

class ArticleItem extends StatelessWidget {
  final Article _article;
  final VoidCallback _onPressed;

  const ArticleItem({
    super.key,
    required this._article,
    required this._onPressed,
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
                    placeholder: (_, _) =>
                        const ShimmerBox(width: imageSide, height: imageSide),
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
