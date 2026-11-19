import 'package:dio/src/cancel_token.dart';
import 'package:news_shower/data/source/remote/dto/news_response_dto.dart';
import 'package:news_shower/data/source/remote/news_api.dart';

class NewsApiFake extends NewsApi {
  final Future<NewsResponseDto> Function() _result;
  String? query;
  CancelToken? cancelToken;
  int? pageIndex;
  int? pageSize;

  NewsApiFake(this._result);

  @override
  Future<NewsResponseDto> getNewsByQuery(
    String query,
    int pageIndex,
    int pageSize,
    CancelToken cancelToken,
  ) {
    this.query = query;
    this.cancelToken = cancelToken;
    this.pageIndex = pageIndex;
    this.pageSize = pageSize;
    return _result();
  }
}
