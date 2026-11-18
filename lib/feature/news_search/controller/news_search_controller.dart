import 'package:flutter/foundation.dart';
import 'package:news_shower/feature/news_search/controller/news_search_state.dart';

class NewsSearchController extends ChangeNotifier {
  NewsSearchState state = NewsSearchState(isSearchButtonEnabled: false);

  void onSearchQueryChanged(String query) {
    state = state.copyWith(isSearchButtonEnabled: query.isNotEmpty);
    notifyListeners();
  }
}
