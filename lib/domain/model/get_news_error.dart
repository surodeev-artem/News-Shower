import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_news_error.freezed.dart';

@freezed
sealed class GetNewsError with _$GetNewsError {
  const factory GetNewsError.rateLimited() = GetNewsErrorRateLimited;
  const factory GetNewsError.apiKeyDisabled() = GetNewsErrorApiKeyDisabled;
  const factory GetNewsError.apiKeyExhausted() = GetNewsErrorApiKeyExhausted;
  const factory GetNewsError.apiKeyInvalid() = GetNewsErrorApiKeyInvalid;
  const factory GetNewsError.apiKeyMissing() = GetNewsErrorApiKeyMissing;
  const factory GetNewsError.maximumResultsReached() =
      GetNewsErrorMaximumResultsReached;
  const factory GetNewsError.unexpected() = GetNewsErrorUnexpected;
}
