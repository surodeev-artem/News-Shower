import 'package:news_shower/domain/model/get_news_result.dart';

abstract class NewsRepository {
  Stream<GetNewsResult> getNewsByQuery(String query);
}
