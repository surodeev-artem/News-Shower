import 'package:material_ui/material_ui.dart';
import 'package:news_shower/di/app_injector.dart';
import 'package:news_shower/feature/news_list/controller/news_list_controller.dart';

final class NewsListScreen extends StatefulWidget {
  final String query;

  const NewsListScreen({super.key, required this.query});

  @override
  State<StatefulWidget> createState() {
    return _NewsListScreenState();
  }
}

final class _NewsListScreenState extends State<NewsListScreen> {
  late final NewsListController _newsListController;

  @override
  void initState() {
    super.initState();
    _newsListController = NewsListController(
      AppInjector.resolve(),
      widget.query,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text(widget.query));
  }
}
