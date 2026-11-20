import 'package:material_ui/material_ui.dart';
import 'package:news_shower/di/app_injector.dart';
import 'package:news_shower/feature/news_list/controller/news_list_controller.dart';
import 'package:news_shower/feature/news_list/ui/news_list_screen.dart';

class NewsListRoute extends StatefulWidget {
  final String query;

  const NewsListRoute({super.key, required this.query});

  @override
  State<NewsListRoute> createState() => _NewsListRouteState();
}

class _NewsListRouteState extends State<NewsListRoute> {
  late final NewsListController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AppInjector.resolve(param1: widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return NewsListScreen(controller: _controller, query: widget.query);
  }
}
