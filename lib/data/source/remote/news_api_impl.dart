import 'package:dio/dio.dart';
import 'package:news_shower/data/source/remote/news_api.dart';
import 'package:rxdart/rxdart.dart';

class NewsApiImpl extends NewsApi {
  final Dio _dio;

  NewsApiImpl(this._dio);

  @override
  Stream<Map<String, dynamic>> getNewsByQuery(
    String query,
    int pageIndex,
    int pageSize,
  ) {
    final cancelToken = CancelToken();

    final response = _dio.get<Map<String, dynamic>>(
      '/everything',
      queryParameters: {
        'q': query,
        'pageSize': pageSize,
        'page': pageIndex,
        'sortBy': 'publishedAt',
      },
      cancelToken: cancelToken,
    );

    return Stream.fromFuture(response)
        .map((response) {
          if (response.statusCode != 200) {
            throw Exception('Not OK status code');
          }

          final data = response.data;
          if (data == null) {
            throw Exception('Response is empty');
          }
          return data;
        })
        .doOnCancel(() {
          if (!cancelToken.isCancelled) {
            cancelToken.cancel();
          }
        });
  }
}
