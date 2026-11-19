import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:news_shower/domain/model/get_news_result.dart';
import 'package:news_shower/domain/repository/news_repository.dart';
import 'package:news_shower/feature/news_list/controller/model/article.dart';
import 'package:news_shower/feature/news_list/controller/model/article_model_mapper.dart';
import 'package:news_shower/feature/news_list/controller/model/get_news_error_mapper.dart';
import 'package:news_shower/feature/news_list/controller/model/news_list_error.dart';
import 'package:news_shower/feature/news_list/controller/model/news_list_state.dart';

const int _pageSize = 20;

class NewsListController extends ChangeNotifier {
  final NewsRepository _newsRepository;
  final String _query;

  StreamSubscription<GetNewsResult>? _subscription;

  NewsListState state = const NewsListState.init();

  NewsListController(this._newsRepository, this._query) {
    load();
  }

  void load() {
    final currentState = state;

    if (currentState is NewsListStateLoading) return;
    if (currentState is NewsListStateData &&
        (currentState.isLoadingMore || currentState.hasReachedEnd)) {
      return;
    }

    state = currentState is NewsListStateData
        ? currentState.copyWith(isLoadingMore: true, loadMoreError: null)
        : const NewsListState.loading();
    notifyListeners();

    final currentPage = currentState is NewsListStateData
        ? currentState.page + 1
        : 1;

    _subscription?.cancel();
    _subscription = _newsRepository
        .getNewsByQuery(query: _query, page: currentPage, pageSize: _pageSize)
        .listen((resultModel) {
          switch (resultModel) {
            case GetNewsResultSuccess():
              {
                final List<Article> previousArticles =
                    currentState is NewsListStateData
                    ? currentState.articles
                    : const [];

                final currentArticles = resultModel.articles.map(
                  ArticleModelMapper.map,
                );

                final newArticles = [...previousArticles, ...currentArticles];

                if (newArticles.isEmpty) {
                  state = const NewsListState.empty();
                  break;
                }

                state = currentState is NewsListStateData
                    ? currentState.copyWith(
                        articles: newArticles,
                        page: currentPage,
                        isLoadingMore: false,
                        loadMoreError: null,
                        hasReachedEnd: currentArticles.length < _pageSize,
                      )
                    : NewsListState.data(
                        articles: newArticles,
                        page: currentPage,
                        isLoadingMore: false,
                        loadMoreError: null,
                        hasReachedEnd: currentArticles.length < _pageSize,
                      );
                break;
              }
            case GetNewsResultFailure():
              {
                final error = GetNewsErrorMapper.map(resultModel.error);

                state = currentState is NewsListStateData
                    ? currentState.copyWith(
                        isLoadingMore: false,
                        loadMoreError: error,
                        hasReachedEnd:
                            error is NewsListErrorMaximumResultsReached,
                      )
                    : NewsListState.failure(error: error);

                break;
              }
          }

          notifyListeners();
        });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
