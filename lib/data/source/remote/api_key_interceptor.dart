import 'package:dio/dio.dart';
import 'package:news_shower/data/source/local/api_key_provider.dart';

const String _apiKeyHeader = 'X-Api-Key';

class ApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[_apiKeyHeader] = ApiKeyProvider.apiKey;
    handler.next(options);
  }
}
