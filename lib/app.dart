import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:material_ui/material_ui.dart';
import 'package:news_shower/l10n/app_localizations.dart';
import 'package:news_shower/navigation/app_routes.dart';
import 'package:news_shower/navigation/routes_generator.dart';

class NewShowerApp extends StatelessWidget {
  const NewShowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes Shower',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: AppRoutes.search,
      onGenerateRoute: RoutesGenerator.generate,
    );
  }
}
