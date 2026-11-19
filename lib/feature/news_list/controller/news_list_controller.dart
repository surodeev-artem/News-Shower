import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:news_shower/domain/model/get_news_error.dart';
import 'package:news_shower/domain/model/get_news_result.dart';
import 'package:news_shower/domain/repository/news_repository.dart';
import 'package:news_shower/feature/news_list/controller/news_list.dart';
import 'package:news_shower/feature/news_list/controller/news_list_error.dart';
import 'package:news_shower/feature/news_list/controller/news_list_state.dart';

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
                    ? currentState.data.news
                    : const [];

                final currentArticles = resultModel.news.articles.map(
                  (article) => Article(
                    article.title,
                    article.description,
                    article.publishedAt,
                    article.urlToImage,
                    article.url,
                    article.source,
                  ),
                );

                final newArticles = [...previousArticles, ...currentArticles];

                if (newArticles.isEmpty) {
                  state = const NewsListState.empty();
                  break;
                }

                state = currentState is NewsListStateData
                    ? currentState.copyWith(
                        data: NewsList(newArticles),
                        page: currentPage,
                        isLoadingMore: false,
                        loadMoreError: null,
                        hasReachedEnd:
                            resultModel.totalResult <= newArticles.length,
                      )
                    : NewsListState.data(
                        data: NewsList(newArticles),
                        page: currentPage,
                        isLoadingMore: false,
                        loadMoreError: null,
                        hasReachedEnd:
                            resultModel.totalResult <= newArticles.length,
                      );
                break;
              }
            case GetNewsResultFailure():
              {
                final error = switch (resultModel.error) {
                  GetNewsResultRateLimitedError() =>
                    NewsListError.rateLimited(),
                  GetNewsResultApiKeyDisabledError() =>
                    NewsListError.apiKeyDisabled(),
                  GetNewsResultApiKeyExhaustedError() =>
                    NewsListError.apiKeyExhausted(),
                  GetNewsResultApiKeyInvalidError() =>
                    NewsListError.apiKeyInvalid(),
                  GetNewsResultApiKeyMissingError() =>
                    NewsListError.apiKeyMissing(),
                  GetNewsResultUnexpectedError() => NewsListError.unexpected(),
                  GetNewsResultMaximumResultsReachedError() =>
                    NewsListError.maximumResultsReached(),
                };

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
