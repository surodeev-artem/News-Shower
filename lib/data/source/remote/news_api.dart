import 'package:dio/dio.dart';
import 'package:news_shower/data/source/remote/dto/news_response_dto.dart';

class NewsApi {
  final Dio _dio;

  const NewsApi(this._dio);

  Future<NewsResponseDto> getNewsByQuery(
    String query,
    int pageIndex,
    int pageSize,
    CancelToken cancelToken,
  ) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/everything',
      queryParameters: {
        'q': query,
        'pageSize': pageSize,
        'page': pageIndex,
        'sortBy': 'publishedAt',
      },
      cancelToken: cancelToken,
    );
    final data = response.data;
    if (data == null) {
      throw const FormatException('News response is empty');
    }
    return NewsResponseDto.fromJson(data);
  }
}
