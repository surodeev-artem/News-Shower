sealed class GetNewsError {
  const GetNewsError();

  factory GetNewsError.rateLimited() => GetNewsResultRateLimitedError();
  factory GetNewsError.apiKeyDisabled() => GetNewsResultApiKeyDisabledError();
  factory GetNewsError.apiKeyExhausted() => GetNewsResultApiKeyExhaustedError();
  factory GetNewsError.apiKeyInvalid() => GetNewsResultApiKeyInvalidError();
  factory GetNewsError.apiKeyMissing() => GetNewsResultApiKeyMissingError();
  factory GetNewsError.unexpected() => GetNewsResultUnexpectedError();
}

final class GetNewsResultRateLimitedError extends GetNewsError;
final class GetNewsResultApiKeyDisabledError extends GetNewsError;
final class GetNewsResultApiKeyExhaustedError extends GetNewsError;
final class GetNewsResultApiKeyInvalidError extends GetNewsError;
final class GetNewsResultApiKeyMissingError extends GetNewsError;
final class GetNewsResultUnexpectedError extends GetNewsError;
