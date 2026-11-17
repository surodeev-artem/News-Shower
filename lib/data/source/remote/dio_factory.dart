import 'package:dio/dio.dart';
import 'package:news_shower/data/source/remote/api_key_interceptor.dart';

const String _baseUrl = "https://newsapi.org/v2";

class DioFactory {
  final ApiKeyInterceptor _apiKeyInterceptor;

  DioFactory(this._apiKeyInterceptor);

  Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
    dio.interceptors.add(_apiKeyInterceptor);
    return dio;
  }
}
