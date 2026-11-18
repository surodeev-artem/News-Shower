abstract final class AppRoutes {
  static const search = '/';
  static const newsList = '/news';
}

class NewsListArgs {
  final String query;

  const NewsListArgs({required this.query});
}
