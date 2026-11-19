sealed class NewsListError {
  const NewsListError();

  factory NewsListError.rateLimited() => NewsListErrorRateLimited();
  factory NewsListError.apiKeyDisabled() => NewsListErrorApiKeyDisabled();
  factory NewsListError.apiKeyExhausted() => NewsListErrorApiKeyExhausted();
  factory NewsListError.apiKeyInvalid() => NewsListErrorApiKeyInvalid();
  factory NewsListError.apiKeyMissing() => NewsListErrorApiKeyMissing();
  factory NewsListError.maximumResultsReached() =>
      NewsListErrorMaximumResultsReached();
  factory NewsListError.unexpected() => NewsListErrorUnexpected();
}

final class NewsListErrorRateLimited extends NewsListError;
final class NewsListErrorApiKeyDisabled extends NewsListError;
final class NewsListErrorApiKeyExhausted extends NewsListError;
final class NewsListErrorApiKeyInvalid extends NewsListError;
final class NewsListErrorApiKeyMissing extends NewsListError;
final class NewsListErrorMaximumResultsReached extends NewsListError;
final class NewsListErrorUnexpected extends NewsListError;
