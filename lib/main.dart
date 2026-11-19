import 'package:material_ui/material_ui.dart';
import 'package:news_shower/app.dart';
import 'package:news_shower/di/app_injector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppInjector.init();

  runApp(const NewsShowerApp());
}
