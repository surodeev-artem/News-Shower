final class NewsList {
  final List<Article> news;

  const NewsList(this.news);
}

final class Article {
  final String? title;
  final String? description;
  final String? publishedAt;
  final String? urlToImage;
  final String? url;
  final String? source;

  const Article(
    this.title,
    this.description,
    this.publishedAt,
    this.urlToImage,
    this.url,
    this.source,
  );
}
