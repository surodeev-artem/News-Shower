import 'package:material_ui/material_ui.dart';
import 'package:news_shower/feature/news_search/ui/news_search_screen.dart';

class NewShowerApp extends StatelessWidget {
  const NewShowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: NewsSearchScreen(),
    );
  }
}
