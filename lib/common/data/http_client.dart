import 'package:dio/dio.dart';
import 'package:news_shower/common/data/empty_response_exception.dart';
import 'package:news_shower/common/data/http_exception.dart';
import 'package:rxdart/rxdart.dart';

final class HttpClient {
  final Dio _dio;

  HttpClient(this._dio);

  Stream<Map<String, dynamic>> get({
    required String path,
    required Map<String, dynamic> queryParameters,
  }) {
    final cancelToken = CancelToken();

    final response = _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );

    return Stream.fromFuture(response)
        .map((response) {
          if (response.statusCode != 200) {
            throw const HttpException();
          }

          final data = response.data;
          if (data == null) {
            throw const EmptyResponseException();
          }
          return data;
        })
        .onErrorResume((e, _) {
          if (e is HttpException || e is EmptyResponseException) {
            return Stream.error(e);
          }

          if (e is DioException && CancelToken.isCancel(e)) {
            return const Stream.empty();
          }

          final data = e is DioException ? e.response?.data : null;
          if (data is Map) {
            return Stream.value(Map<String, dynamic>.from(data));
          }

          return Stream.error(const HttpException());
        })
        .doOnCancel(() {
          if (!cancelToken.isCancelled) {
            cancelToken.cancel();
          }
        });
  }
}
