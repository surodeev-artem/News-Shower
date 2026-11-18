// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get searchTitle => 'Поиск';

  @override
  String get queryPlaceholder => 'Ваш запрос...';

  @override
  String get searchButton => 'Найти';

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
}
