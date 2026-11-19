import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:news_shower/l10n/app_localizations.dart';
import 'package:news_shower/navigation/app_routes.dart';

Future<void> pumpScreen(WidgetTester tester, Widget screen) {
  return tester.pumpWidget(
    MaterialApp(
      locale: const Locale('ru'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: screen,
      onGenerateRoute: (settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) {
            final args = settings.arguments;
            if (args is NewsListArgs && args.query.isNotEmpty) {
              return Scaffold(body: Text('route:${args.query}'));
            } else {
              return const Scaffold(body: Text('route'));
            }
          },
        );
      },
    ),
  );
}
