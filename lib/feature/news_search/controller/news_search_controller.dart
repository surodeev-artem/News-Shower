import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:news_shower/common/domain/link_launcher.dart';
import 'package:news_shower/domain/model/get_news_result.dart';
import 'package:news_shower/domain/repository/news_repository.dart';
import 'package:news_shower/feature/news_search/controller/model/article.dart';
import 'package:news_shower/feature/news_search/controller/model/article_model_mapper.dart';
import 'package:news_shower/feature/news_search/controller/model/get_news_error_mapper.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_error.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_item.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_state.dart';
import 'package:news_shower/feature/news_search/controller/model/news_search_effect.dart';
import 'package:news_shower/feature/news_search/controller/model/news_search_state.dart';
import 'package:rxdart/rxdart.dart';

const int _pageSize = 20;

class NewsSearchController extends ChangeNotifier {
  final NewsRepository _newsRepository;
  final LinkLauncher _linkLauncher;

  final _effectController = StreamController<NewsSearchEffect>();
  late final Stream<NewsSearchEffect> effect = _effectController.stream;

  final _loadRequests = PublishSubject<void>();
  late StreamSubscription<GetNewsResult> _loads;

  NewsSearchState _state = const NewsSearchState(
    query: '',
    isSearchButtonEnabled: false,
    listState: NewsListState.init(),
  );
  NewsSearchState get state => _state;

  NewsSearchController(this._newsRepository, this._linkLauncher) {
    _loads = _subscribeLoads();
  }

  void onSearchQueryChanged(String query) {
    final trimmedQuery = query.trim();
    _state = state.copyWith(
      query: trimmedQuery,
      isSearchButtonEnabled: trimmedQuery.isNotEmpty,
    );
    notifyListeners();
  }

  void onSearchButtonPressed(String query) {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) return;
    _state = state.copyWith(
      query: trimmedQuery,
      isSearchButtonEnabled: query.trim().isNotEmpty,
      listState: const NewsListState.init(),
    );
    notifyListeners();

    _loads.cancel();
    _loads = _subscribeLoads();

    load();
  }

  void load() => _loadRequests.add(null);

  Future<void> onArticlePressed(String? articleUrl) async {
    final url = articleUrl;
    if (url == null || url.isEmpty) {
      _effectController.add(const NewsSearchEffect.articleUrlIsNotValid());
      return;
    }
    final uri = Uri.tryParse(url);
    if (uri == null ||
        !uri.hasScheme ||
        (!uri.isScheme('HTTP') && !uri.isScheme('HTTPS'))) {
      _effectController.add(const NewsSearchEffect.articleUrlIsNotValid());
      return;
    }
    try {
      final result = await _linkLauncher.launch(uri);
      if (!result) {
        _effectController.add(const NewsSearchEffect.articleUrlIsNotValid());
      }
    } catch (e) {
      _effectController.add(const NewsSearchEffect.articleUrlIsNotValid());
    }
  }

  StreamSubscription<GetNewsResult> _subscribeLoads() =>
      _loadRequests.exhaustMap(_startLoad).listen(_applyState);

  Stream<GetNewsResult> _startLoad(void _) {
    final currentState = state;
    final currentListState = state.listState;

    if (currentListState is NewsListStateData &&
        currentListState.hasReachedEnd) {
      return const Stream.empty();
    }

    _state = state.copyWith(
      listState: currentListState is NewsListStateData
          ? currentListState.copyWith(isLoadingMore: true, loadMoreError: null)
          : const NewsListState.loading(),
    );
    notifyListeners();

    final currentPage = currentListState is NewsListStateData
        ? currentListState.page + 1
        : 1;

    return _newsRepository.getNewsByQuery(
      query: currentState.query,
      page: currentPage,
      pageSize: _pageSize,
    );
  }

  void _applyState(GetNewsResult result) {
    final currentListState = state.listState;

    final previousArticles = currentListState is NewsListStateData
        ? currentListState.articles
        : const <Article>[];
    final currentPage = currentListState is NewsListStateData
        ? currentListState.page + 1
        : 1;

    switch (result) {
      case GetNewsResultSuccess():
        {
          final currentArticles = result.articles.map(ArticleModelMapper.map);
          final newArticles = [...previousArticles, ...currentArticles];

          if (newArticles.isEmpty) {
            _state = state.copyWith(listState: const NewsListState.empty());
            break;
          }

          final newListItems = _groupByDate(newArticles);
          _state = state.copyWith(
            listState: currentListState is NewsListStateData
                ? currentListState.copyWith(
                    articles: newArticles,
                    items: newListItems,
                    page: currentPage,
                    isLoadingMore: false,
                    loadMoreError: null,
                    hasReachedEnd: currentArticles.isEmpty,
                  )
                : NewsListState.data(
                    articles: newArticles,
                    items: newListItems,
                    page: currentPage,
                    isLoadingMore: false,
                    loadMoreError: null,
                    hasReachedEnd: currentArticles.isEmpty,
                  ),
          );
          break;
        }
      case GetNewsResultFailure():
        {
          final error = GetNewsErrorMapper.map(result.error);

          _state = state.copyWith(
            listState: currentListState is NewsListStateData
                ? currentListState.copyWith(
                    isLoadingMore: false,
                    loadMoreError: error,
                    hasReachedEnd: error is NewsListErrorMaximumResultsReached,
                  )
                : NewsListState.failure(error: error),
          );

          break;
        }
    }
    notifyListeners();
  }

  List<NewsListItem> _groupByDate(List<Article> articles) {
    final items = <NewsListItem>[];
    DateTime? currentDay;
    var isUnknownGroupOpen = false;
    for (final article in articles) {
      final publishedAt = article.publishedAt;
      if (publishedAt == null) {
        if (!isUnknownGroupOpen) {
          items.add(const NewsListItem.unknownDate());
          isUnknownGroupOpen = true;
          currentDay = null;
        }
        items.add(NewsListItem.article(article));
        continue;
      }
      final day = DateTime(
        publishedAt.year,
        publishedAt.month,
        publishedAt.day,
      );
      if (isUnknownGroupOpen || day != currentDay) {
        items.add(NewsListItem.date(day));
        currentDay = day;
        isUnknownGroupOpen = false;
      }
      items.add(NewsListItem.article(article));
    }
    return items;
  }

  @override
  void dispose() {
    _loads.cancel();
    _loadRequests.close();
    _effectController.close();
    super.dispose();
  }
}
