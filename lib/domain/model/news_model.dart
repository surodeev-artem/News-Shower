final class NewsModel {
  final List<ArticleModel> articles;

  const NewsModel(this.articles);
}

final class ArticleModel {
  final String? title;
  final String? description;
  final DateTime? publishedAt;
  final String? urlToImage;
  final String? url;
  final String? source;

  const ArticleModel(
    this.title,
    this.description,
    this.publishedAt,
    this.urlToImage,
    this.url,
    this.source,
  );
}
