import 'package:flutter_test/flutter_test.dart';
import 'package:news_shower/domain/model/get_news_error.dart';
import 'package:news_shower/feature/news_list/controller/model/get_news_error_mapper.dart';
import 'package:news_shower/feature/news_list/controller/model/news_list_error.dart';

void main() {
  group('Maps GetNewsError to NewsListError', () {
    for (final error in {
      const GetNewsErrorMaximumResultsReached():
          const NewsListError.maximumResultsReached(),
      const GetNewsErrorApiKeyDisabled(): const NewsListError.apiKeyDisabled(),
      const GetNewsErrorApiKeyExhausted():
          const NewsListError.apiKeyExhausted(),
      const GetNewsErrorApiKeyInvalid(): const NewsListError.apiKeyInvalid(),
      const GetNewsErrorApiKeyMissing(): const NewsListError.apiKeyMissing(),
      const GetNewsErrorRateLimited(): const NewsListError.rateLimited(),
      const GetNewsErrorUnexpected(): const NewsListError.unexpected(),
    }.entries) {
      test('Maps ${error.key} to ${error.value}', () {
        final mappedError = GetNewsErrorMapper.map(error.key);

        expect(mappedError, error.value);
      });
    }
  });
}
