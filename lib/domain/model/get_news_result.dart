import 'package:news_shower/domain/model/get_news_error.dart';
import 'package:news_shower/domain/model/news_model.dart';

sealed class GetNewsResult {
  const GetNewsResult();

  factory GetNewsResult.success(NewsModel news, int totalResult) =>
      GetNewsResultSuccess(news, totalResult);
  factory GetNewsResult.failure(GetNewsError error) =>
      GetNewsResultFailure(error);
}

final class GetNewsResultSuccess(final NewsModel news, final int totalResult)
    extends GetNewsResult;
final class GetNewsResultFailure(final GetNewsError error)
    extends GetNewsResult;
