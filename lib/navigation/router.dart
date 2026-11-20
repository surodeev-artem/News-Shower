import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:news_shower/navigation/news_list_route.dart';
import 'package:news_shower/navigation/news_search_route.dart';

final router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final isNews = state.uri.path == NewsListLocation.path;
    final query = state.uri.queryParameters['query']?.trim() ?? '';
    if (isNews && query.isEmpty) return const NewsSearchLocation().location;
    return null;
  },
  routes: [
    GoRoute(
      path: NewsSearchLocation.path,
      builder: (context, state) => const NewsSearchRoute(),
    ),
    GoRoute(
      path: NewsListLocation.path,
      builder: (context, state) {
        final query = state.uri.queryParameters['query']!.trim();

        return NewsListRoute(key: ValueKey(query), query: query);
      },
    ),
  ],
);

sealed class Location {
  String get location;

  const Location();

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);
}

final class NewsSearchLocation extends Location {
  static const path = '/';

  const NewsSearchLocation();

  @override
  String get location => path;
}

final class NewsListLocation extends Location {
  static const path = '/list';
  final String query;

  const NewsListLocation(this.query);

  @override
  String get location =>
      Uri(path: path, queryParameters: {'query': query.trim()}).toString();
}
