import 'package:news_shower/domain/model/get_news_error.dart';
import 'package:news_shower/feature/news_list/controller/model/news_list_error.dart';

final class GetNewsErrorMapper {
  static NewsListError map(GetNewsError error) {
    return switch (error) {
      GetNewsErrorRateLimited() => const NewsListError.rateLimited(),
      GetNewsErrorApiKeyDisabled() => const NewsListError.apiKeyDisabled(),
      GetNewsErrorApiKeyExhausted() => const NewsListError.apiKeyExhausted(),
      GetNewsErrorApiKeyInvalid() => const NewsListError.apiKeyInvalid(),
      GetNewsErrorApiKeyMissing() => const NewsListError.apiKeyMissing(),
      GetNewsErrorUnexpected() => const NewsListError.unexpected(),
      GetNewsErrorMaximumResultsReached() =>
        const NewsListError.maximumResultsReached(),
    };
  }
}
