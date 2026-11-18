import 'package:material_ui/material_ui.dart';
import 'package:news_shower/common/app_localizations_ext.dart';
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
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.searchTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Padding(padding: EdgeInsetsGeometry.only(top: 16)),
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: context.l10n.queryPlaceholder,
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _controller.onSearchQueryChanged(value);
                },
              ),
              Padding(padding: EdgeInsetsGeometry.only(top: 8)),
              SizedBox(
                width: double.infinity,
                child: ListenableBuilder(
                  listenable: _controller,
                  builder: (_, _) => FilledButton(
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
                    child: Text(context.l10n.searchButton),
                  ),
                ),
              ),
            ],
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
