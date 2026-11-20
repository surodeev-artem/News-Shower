import 'package:material_ui/material_ui.dart';
import 'package:news_shower/di/app_injector.dart';
import 'package:news_shower/feature/news_search/controller/news_search_controller.dart';
import 'package:news_shower/feature/news_search/ui/news_search_screen.dart';

class NewsSearchRoute extends StatefulWidget {
  const NewsSearchRoute({super.key});

  @override
  State<NewsSearchRoute> createState() => _NewsSearchRouteState();
}

class _NewsSearchRouteState extends State<NewsSearchRoute> {
  late final NewsSearchController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AppInjector.resolve();
  }

  @override
  Widget build(BuildContext context) {
    return NewsSearchScreen(controller: _controller);
  }
}
