import 'package:material_ui/material_ui.dart';
import 'package:news_shower/l10n/app_localizations.dart';
import 'package:news_shower/navigation/router.dart';

class NewsShowerApp extends StatelessWidget {
  const NewsShowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final seedColor = Colors.deepPurple;
    return MaterialApp.router(
      title: 'News Shower',
      localizationsDelegates: [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: seedColor)),
      darkTheme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
      ),
      routerConfig: router,
    );
  }
}
