final class NewsModel {
  final List<NewsItemModel> news;

  const NewsModel(this.news);
}

final class NewsItemModel {
  final String? title;
  final String? description;
  final String? publishedAt;
  final String? urlToImage;
  final String? url;
  final String? source;

  const NewsItemModel(
    this.title,
    this.description,
    this.publishedAt,
    this.urlToImage,
    this.url,
    this.source,
  );
}
