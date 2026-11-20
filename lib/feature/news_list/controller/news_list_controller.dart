import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:news_shower/common/domain/link_launcher.dart';
import 'package:news_shower/domain/model/get_news_result.dart';
import 'package:news_shower/domain/repository/news_repository.dart';
import 'package:news_shower/feature/news_list/controller/model/article.dart';
import 'package:news_shower/feature/news_list/controller/model/article_model_mapper.dart';
import 'package:news_shower/feature/news_list/controller/model/get_news_error_mapper.dart';
import 'package:news_shower/feature/news_list/controller/model/news_list_effect.dart';
import 'package:news_shower/feature/news_list/controller/model/news_list_error.dart';
import 'package:news_shower/feature/news_list/controller/model/news_list_item.dart';
import 'package:news_shower/feature/news_list/controller/model/news_list_state.dart';
import 'package:rxdart/rxdart.dart';

const int _pageSize = 20;

class NewsListController extends ChangeNotifier {
  final NewsRepository _newsRepository;
  final LinkLauncher _linkLauncher;
  final String _query;

  final _effectController = StreamController<NewsListEffect>();
  late final Stream<NewsListEffect> effect = _effectController.stream;

  NewsListState _state = const NewsListState.init();
  NewsListState get state => _state;

  final _loadRequests = PublishSubject<void>();
  late final StreamSubscription<GetNewsResult> _loads;

  NewsListController(this._newsRepository, this._linkLauncher, this._query) {
    _loads = _loadRequests.exhaustMap(_startLoad).listen(_applyState);
  }

  void load() => _loadRequests.add(null);

  Future<void> onArticlePressed(String? articleUrl) async {
    final url = articleUrl;
    if (url == null || url.isEmpty) {
      _effectController.add(const NewsListEffect.articleUrlIsNotValid());
      return;
    }
    final uri = Uri.tryParse(url);
    if (uri == null ||
        !uri.hasScheme ||
        (!uri.isScheme('HTTP') && !uri.isScheme('HTTPS'))) {
      _effectController.add(const NewsListEffect.articleUrlIsNotValid());
      return;
    }
    try {
      final result = await _linkLauncher.launch(uri);
      if (!result) {
        _effectController.add(const NewsListEffect.articleUrlIsNotValid());
      }
    } catch (e) {
      _effectController.add(const NewsListEffect.articleUrlIsNotValid());
    }
  }

  Stream<GetNewsResult> _startLoad(void _) {
    final currentState = state;
    if (currentState is NewsListStateData && currentState.hasReachedEnd) {
      return const Stream.empty();
    }

    _state = currentState is NewsListStateData
        ? currentState.copyWith(isLoadingMore: true, loadMoreError: null)
        : const NewsListState.loading();
    notifyListeners();

    final currentPage = currentState is NewsListStateData
        ? currentState.page + 1
        : 1;

    return _newsRepository.getNewsByQuery(
      query: _query,
      page: currentPage,
      pageSize: _pageSize,
    );
  }

  void _applyState(GetNewsResult result) {
    final currentState = state;

    final previousArticles = currentState is NewsListStateData
        ? currentState.articles
        : const <Article>[];
    final currentPage = currentState is NewsListStateData
        ? currentState.page + 1
        : 1;

    switch (result) {
      case GetNewsResultSuccess():
        {
          final currentArticles = result.articles.map(ArticleModelMapper.map);

          final newArticles = [...previousArticles, ...currentArticles];

          if (newArticles.isEmpty) {
            _state = const NewsListState.empty();
            break;
          }

          final newListItems = _groupByDate(newArticles);
          _state = currentState is NewsListStateData
              ? currentState.copyWith(
                  articles: newArticles,
                  items: newListItems,
                  page: currentPage,
                  isLoadingMore: false,
                  loadMoreError: null,
                  hasReachedEnd: currentArticles.length < _pageSize,
                )
              : NewsListState.data(
                  articles: newArticles,
                  items: newListItems,
                  page: currentPage,
                  isLoadingMore: false,
                  loadMoreError: null,
                  hasReachedEnd: currentArticles.length < _pageSize,
                );
          break;
        }
      case GetNewsResultFailure():
        {
          final error = GetNewsErrorMapper.map(result.error);

          _state = currentState is NewsListStateData
              ? currentState.copyWith(
                  isLoadingMore: false,
                  loadMoreError: error,
                  hasReachedEnd: error is NewsListErrorMaximumResultsReached,
                )
              : NewsListState.failure(error: error);

          break;
        }
    }
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
