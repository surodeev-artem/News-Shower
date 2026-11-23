import 'package:news_shower/data/source/remote/dto/news_response_dto.dart';
import 'package:news_shower/data/source/remote/news_api.dart';

final class NewsApiFake extends NewsApi {
  final Stream<NewsResponseDto> Function() _result;

  String? query;
  int? pageIndex;
  int? pageSize;

  NewsApiFake(this._result);

  @override
  Stream<NewsResponseDto> getNewsByQuery(
    String query,
    int pageIndex,
    int pageSize,
  ) {
    this.query = query;
    this.pageIndex = pageIndex;
    this.pageSize = pageSize;
    return _result();
  }
}
