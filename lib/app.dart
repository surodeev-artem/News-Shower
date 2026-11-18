import 'package:material_ui/material_ui.dart';
import 'package:news_shower/navigation/app_routes.dart';
import 'package:news_shower/navigation/routes_generator.dart';

class NewShowerApp extends StatelessWidget {
  const NewShowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: AppRoutes.search,
      onGenerateRoute: RoutesGenerator.generate,
    );
  }
}
