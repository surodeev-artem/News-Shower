import 'package:dio/dio.dart';

const String _baseUrl = "https://newsapi.org/v2";

class DioFactory {
  Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
    return dio;
  }
}
