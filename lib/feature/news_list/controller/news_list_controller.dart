import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:news_shower/domain/model/get_news_error.dart';
import 'package:news_shower/domain/model/get_news_result.dart';
import 'package:news_shower/domain/repository/news_repository.dart';
import 'package:news_shower/feature/news_list/controller/news_list.dart';
import 'package:news_shower/feature/news_list/controller/news_list_error.dart';
import 'package:news_shower/feature/news_list/controller/news_list_state.dart';

class NewsController extends ChangeNotifier {
  final NewsRepository _newsRepository;
  final String _query;

  StreamSubscription<GetNewsResult>? subscription;

  NewsListState state = NewsListState.loading();

  NewsController(this._newsRepository, this._query) {
    load();
  }

  void load() {
    subscription?.cancel();
    subscription = _newsRepository.getNewsByQuery(_query).listen((resultModel) {
      switch (resultModel) {
        case GetNewsResultSuccess():
          {
            if (resultModel.news.news.isEmpty) {
              state = NewsListState.empty();

              break;
            }
            final result = NewsList(
              resultModel.news.news
                  .map(
                    (article) => Article(
                      article.title,
                      article.description,
                      article.publishedAt,
                      article.urlToImage,
                      article.url,
                      article.source,
                    ),
                  )
                  .toList(),
            );
            state = NewsListState.success(result);

            break;
          }
        case GetNewsResultFailure():
          {
            state = switch (resultModel.error) {
              GetNewsResultRateLimitedError() => NewsListState.failure(
                NewsListError.rateLimited(),
              ),
              GetNewsResultApiKeyDisabledError() => NewsListState.failure(
                NewsListError.apiKeyDisabled(),
              ),
              GetNewsResultApiKeyExhaustedError() => NewsListState.failure(
                NewsListError.apiKeyExhausted(),
              ),
              GetNewsResultApiKeyInvalidError() => NewsListState.failure(
                NewsListError.apiKeyInvalid(),
              ),
              GetNewsResultApiKeyMissingError() => NewsListState.failure(
                NewsListError.apiKeyMissing(),
              ),
              GetNewsResultUnexpectedError() => NewsListState.failure(
                NewsListError.unexpected(),
              ),
            };

            break;
          }
      }

      notifyListeners();
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}
