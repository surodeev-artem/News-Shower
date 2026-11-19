import 'package:news_shower/domain/model/article_model.dart';
import 'package:news_shower/feature/news_list/controller/model/article.dart';

final class ArticleModelMapper {
  static Article map(ArticleModel model) {
    return Article(
      title: model.title,
      description: model.description,
      publishedAt: model.publishedAt?.toLocal(),
      urlToImage: model.urlToImage,
      url: model.url,
      source: model.source,
    );
  }
}
