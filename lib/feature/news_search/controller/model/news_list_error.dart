import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_list_error.freezed.dart';

@freezed
sealed class NewsListError with _$NewsListError {
  const factory NewsListError.rateLimited() = NewsListErrorRateLimited;
  const factory NewsListError.apiKeyDisabled() = NewsListErrorApiKeyDisabled;
  const factory NewsListError.apiKeyExhausted() = NewsListErrorApiKeyExhausted;
  const factory NewsListError.apiKeyInvalid() = NewsListErrorApiKeyInvalid;
  const factory NewsListError.apiKeyMissing() = NewsListErrorApiKeyMissing;
  const factory NewsListError.maximumResultsReached() =
      NewsListErrorMaximumResultsReached;
  const factory NewsListError.unexpected() = NewsListErrorUnexpected;
}
