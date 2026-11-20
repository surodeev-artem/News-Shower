import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:news_shower/l10n/app_localizations.dart';
import 'package:news_shower/navigation/router.dart';

Future<void> pumpScreen(WidgetTester tester, Widget screen) {
  final router = GoRouter(
    initialLocation: NewsSearchLocation.path,
    routes: [
      GoRoute(
        path: NewsSearchLocation.path,
        builder: (context, state) => screen,
      ),
      GoRoute(
        path: NewsListLocation.path,
        builder: (context, state) {
          final query = state.uri.queryParameters['query']?.trim() ?? '';
          return Scaffold(body: Text('route:$query'));
        },
      ),
    ],
  );
  addTearDown(router.dispose);

  return tester.pumpWidget(
    MaterialApp.router(
      locale: const Locale('ru'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    ),
  );
}
