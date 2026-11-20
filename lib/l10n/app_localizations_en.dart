// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get queryPlaceholder => 'Your query...';

  @override
  String get newsNotFound => 'News not found';

  @override
  String get errorButton => 'Try again';

  @override
  String get errorTooManyRequest => 'Too many requests, please try again later';

  @override
  String get errorApiKeyDisabled => 'API key is disabled';

  @override
  String get errorApiKeyExhausted => 'Request limit reached for this API key';

  @override
  String get errorApiKeyInvalid => 'Invalid API key';

  @override
  String get errorApiKeyMissing => 'API key is missing';

  @override
  String get errorUnexpected => 'Something went wrong';

  @override
  String get errorMaximumResultsReached =>
      'Maximum number of search results reached';

  @override
  String get errorArticleUrlInvalid => 'Invalid article URL';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get unknownDate => 'Unknown date';

  @override
  String publishedAt(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat(
      'MMM d, y HH:mm',
      localeName,
    );
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String publishedAtHeader(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat(
      'MMM d, y',
      localeName,
    );
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }
}
