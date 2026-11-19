import 'package:material_ui/material_ui.dart';
import 'package:news_shower/di/app_injector.dart';
import 'package:news_shower/feature/news_list/ui/news_list_screen.dart';
import 'package:news_shower/feature/news_search/ui/news_search_screen.dart';
import 'package:news_shower/navigation/app_routes.dart';

abstract final class RoutesGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.search:
        return MaterialPageRoute(
          builder: (_) => NewsSearchScreen(controller: AppInjector.resolve()),
        );
      case AppRoutes.newsList:
        final args = settings.arguments;
        if (args is! NewsListArgs || args.query.trim().isEmpty) {
          return MaterialPageRoute(
            builder: (_) => NewsSearchScreen(controller: AppInjector.resolve()),
          );
        }
        return MaterialPageRoute(
          builder: (_) => NewsListScreen(
            controller: AppInjector.resolve(param1: args.query),
            query: args.query,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => NewsSearchScreen(controller: AppInjector.resolve()),
        );
    }
  }
}
