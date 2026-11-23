import 'package:news_shower/data/source/remote/news_api.dart';

final class NewsApiFake extends NewsApi {
  final Stream<Map<String, dynamic>> Function() _result;

  String? query;
  int? pageIndex;
  int? pageSize;

  NewsApiFake(this._result);

  @override
  Stream<Map<String, dynamic>> getNewsByQuery(
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
