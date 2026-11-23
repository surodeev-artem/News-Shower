import 'package:dio/dio.dart';
import 'package:news_shower/data/source/remote/dto/news_response_dto.dart';
import 'package:news_shower/data/source/remote/news_api.dart';
import 'package:rxdart/rxdart.dart';

class NewsApiImpl extends NewsApi {
  final Dio _dio;

  NewsApiImpl(this._dio);

  @override
  Stream<NewsResponseDto> getNewsByQuery(
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
          final data = response.data;
          if (data == null) {
            throw const FormatException('News response is empty');
          }
          return NewsResponseDto.fromJson(data);
        })
        .doOnCancel(() {
          if (!cancelToken.isCancelled) {
            cancelToken.cancel();
          }
        });
  }
}
