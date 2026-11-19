import 'package:flutter/widgets.dart';
import 'package:news_shower/l10n/app_localizations.dart';

extension AppLocalizationsExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
