import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:news_shower/domain/model/get_news_result.dart';
import 'package:news_shower/domain/repository/news_repository.dart';
import 'package:news_shower/feature/news_list/controller/model/article.dart';
import 'package:news_shower/feature/news_list/controller/model/article_model_mapper.dart';
import 'package:news_shower/feature/news_list/controller/model/get_news_error_mapper.dart';
import 'package:news_shower/feature/news_list/controller/model/news_list_effect.dart';
import 'package:news_shower/feature/news_list/controller/model/news_list_error.dart';
import 'package:news_shower/feature/news_list/controller/model/news_list_state.dart';
import 'package:url_launcher/url_launcher.dart';

const int _pageSize = 20;

class NewsListController extends ChangeNotifier {
  final NewsRepository _newsRepository;
  final String _query;

  final _effectController = StreamController<NewsListEffect>();
  late final Stream<NewsListEffect> effect = _effectController.stream;

  NewsListState _state = const NewsListState.init();
  NewsListState get state => _state;

  StreamSubscription<GetNewsResult>? _subscription;

  NewsListController(this._newsRepository, this._query);

  void load() {
    final currentState = state;

    if (currentState is NewsListStateLoading) return;
    if (currentState is NewsListStateData &&
        (currentState.isLoadingMore || currentState.hasReachedEnd)) {
      return;
    }

    _state = currentState is NewsListStateData
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
                  _state = const NewsListState.empty();
                  break;
                }

                _state = currentState is NewsListStateData
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

                _state = currentState is NewsListStateData
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
      final result = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!result) {
        _effectController.add(const NewsListEffect.articleUrlIsNotValid());
      }
    } catch (e) {
      _effectController.add(const NewsListEffect.articleUrlIsNotValid());
      return;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _effectController.close();
    super.dispose();
  }
}
