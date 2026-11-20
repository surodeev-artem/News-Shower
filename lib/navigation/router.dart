import 'package:go_router/go_router.dart';
import 'package:news_shower/navigation/news_search_route.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const NewsSearchRoute()),
  ],
);
