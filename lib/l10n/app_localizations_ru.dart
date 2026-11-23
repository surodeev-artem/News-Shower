// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get queryPlaceholder => 'Ваш запрос...';

  @override
  String get newsNotFound => 'Новостей не найдено';

  @override
  String get errorButton => 'Попробовать снова';

  @override
  String get errorTooManyRequest => 'Слишком много запросов, попробуйте позже';

  @override
  String get errorApiKeyDisabled => 'Выключен ключ API';

  @override
  String get errorApiKeyExhausted =>
      'Достигнут лимит запросов для этого ключа API';

  @override
  String get errorApiKeyInvalid => 'Некорректный ключ API';

  @override
  String get errorApiKeyMissing => 'Отсутствует ключ API';

  @override
  String get errorUnexpected => 'Произошла ошибка';

  @override
  String get errorMaximumResultsReached =>
      'Достигнуто максимальное количество новостей в поиске';

  @override
  String get errorArticleUrlInvalid => 'Некорректный URL статьи';

  @override
  String get today => 'Сегодня';

  @override
  String get yesterday => 'Вчера';

  @override
  String get unknownDate => 'Неизвестная дата';

  @override
  String get searchHint => 'Для поиска новостей воспользуйтесь поиском';

  @override
  String publishedAt(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat(
      'dd.MM.yyyy HH:mm',
      localeName,
    );
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String publishedAtHeader(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat(
      'dd.MM.yyyy',
      localeName,
    );
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }
}
