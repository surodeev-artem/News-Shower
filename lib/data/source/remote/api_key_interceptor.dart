import 'package:dio/dio.dart';

const String _apiKeyHeader = "X-Api-Key";

class ApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[_apiKeyHeader] = "CHANGE IT";
    handler.next(options);
  }
}
