import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:news_shower/feature/news_search/controller/news_search_effect.dart';
import 'package:news_shower/feature/news_search/controller/news_search_state.dart';

class NewsSearchController extends ChangeNotifier {
  final _effectController = StreamController<NewsSearchEffect>();

  NewsSearchState state = NewsSearchState(isSearchButtonEnabled: false);
  late final Stream<NewsSearchEffect> effect = _effectController.stream;

  void onSearchQueryChanged(String query) {
    state = state.copyWith(isSearchButtonEnabled: query.trim().isNotEmpty);
    notifyListeners();
  }

  void onSearchButtonPressed(String query) {
    final normalized = query.trim();
    if (normalized.isEmpty) return;
    _effectController.add(NewsSearchEffect.goToList(query: normalized));
  }

  @override
  void dispose() {
    _effectController.close();
    super.dispose();
  }
}
