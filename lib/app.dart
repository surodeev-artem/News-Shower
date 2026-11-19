import 'package:material_ui/material_ui.dart';
import 'package:news_shower/l10n/app_localizations.dart';
import 'package:news_shower/navigation/app_routes.dart';
import 'package:news_shower/navigation/routes_generator.dart';

class NewsShowerApp extends StatelessWidget {
  const NewsShowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Shower',
      localizationsDelegates: [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: AppRoutes.search,
      onGenerateRoute: RoutesGenerator.generate,
    );
  }
}
