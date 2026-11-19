import 'package:material_ui/material_ui.dart';
import 'package:news_shower/di/app_injector.dart';
import 'package:news_shower/feature/news_list/controller/news_list_controller.dart';
import 'package:news_shower/feature/news_list/ui/news_list_screen.dart';
import 'package:news_shower/feature/news_search/controller/news_search_controller.dart';
import 'package:news_shower/feature/news_search/ui/news_search_screen.dart';
import 'package:news_shower/navigation/app_routes.dart';

abstract final class RoutesGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.search:
        return _newsSearchScreen();
      case AppRoutes.newsList:
        final args = settings.arguments;
        if (args is! NewsListArgs || args.query.trim().isEmpty) {
          return _newsSearchScreen();
        }
        return _newsListScreen(args.query);
      default:
        return _newsSearchScreen();
    }
  }

  static MaterialPageRoute _newsSearchScreen() {
    final NewsSearchController controller = AppInjector.resolve();
    return MaterialPageRoute(
      builder: (_) => NewsSearchScreen(controller: controller),
    );
  }

  static MaterialPageRoute _newsListScreen(String query) {
    final NewsListController controller = AppInjector.resolve(param1: query);
    return MaterialPageRoute(
      builder: (_) => NewsListScreen(controller: controller, query: query),
    );
  }
}
