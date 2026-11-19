import 'package:news_shower/domain/model/get_news_result.dart';
import 'package:news_shower/domain/repository/news_repository.dart';

final class NewsRepositoryFake extends NewsRepository {
  final List<GetNewsResult> results;
  int calls = 0;

  NewsRepositoryFake(this.results);

  @override
  Stream<GetNewsResult> getNewsByQuery({
    required String query,
    required int page,
    required int pageSize,
  }) async* {
    calls++;
    yield results[page - 1];
  }
}
