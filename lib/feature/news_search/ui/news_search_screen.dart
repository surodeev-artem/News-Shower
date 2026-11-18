import 'package:material_ui/material_ui.dart';

class NewsSearchScreen extends StatefulWidget {
  const NewsSearchScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewsSearchScreenState();
  }
}

class _NewsSearchScreenState extends State<NewsSearchScreen> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
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
              Text("Поиск", style: Theme.of(context).textTheme.titleLarge),
              Padding(padding: EdgeInsetsGeometry.only(top: 16)),
              TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  labelText: 'Запрос',
                  border: OutlineInputBorder(),
                ),
              ),
              Padding(padding: EdgeInsetsGeometry.only(top: 8)),
              SizedBox(
                width: double.infinity,
                child: FilledButton(onPressed: () => {}, child: Text("Найти")),
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
    super.dispose();
  }
}
