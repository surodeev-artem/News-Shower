import 'package:news_shower/common/data/http_client.dart';
import 'package:news_shower/data/source/remote/news_api.dart';

class NewsApiImpl extends NewsApi {
  final HttpClient _httpClient;

  NewsApiImpl(this._httpClient);

  @override
  Stream<Map<String, dynamic>> getNewsByQuery(
    String query,
    int pageIndex,
    int pageSize,
  ) {
    return _httpClient.get(
      path: '/everything',
      queryParameters: {
        'q': query,
        'pageSize': pageSize,
        'page': pageIndex,
        'sortBy': 'publishedAt',
      },
    );
  }
}
