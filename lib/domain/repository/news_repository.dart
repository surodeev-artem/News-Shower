import 'package:news_shower/domain/model/get_news_result.dart';

abstract class NewsRepository {
  Stream<GetNewsResult> getNewsByQuery({
    required String query,
    required int page,
    required int pageSize,
  });
}
