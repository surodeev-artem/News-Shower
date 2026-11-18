import 'package:material_ui/material_ui.dart';
import 'package:news_shower/feature/news_search/controller/news_search_controller.dart';
import 'package:news_shower/navigation/app_routes.dart';

class NewsSearchScreen extends StatefulWidget {
  const NewsSearchScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewsSearchScreenState();
  }
}

class _NewsSearchScreenState extends State<NewsSearchScreen> {
  late final TextEditingController _textEditingController;
  late final NewsSearchController _controller;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _controller = NewsSearchController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) => Center(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Поиск", style: Theme.of(context).textTheme.titleLarge),
                Padding(padding: EdgeInsetsGeometry.only(top: 16)),
                TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Запрос',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => {
                    _controller.onSearchQueryChanged(value),
                  },
                ),
                Padding(padding: EdgeInsetsGeometry.only(top: 8)),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _controller.state.isSearchButtonEnabled
                        ? () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.newsList,
                              arguments: NewsListArgs(
                                query: _textEditingController.text,
                              ),
                            );
                          }
                        : null,
                    child: Text("Найти"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
