import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:news_shower/common/data/empty_response_exception.dart';
import 'package:news_shower/data/repository/news_repository_impl.dart';
import 'package:news_shower/domain/model/article_model.dart';
import 'package:news_shower/domain/model/get_news_error.dart';
import 'package:news_shower/domain/model/get_news_result.dart';

import '../source/remote/news_api_fake.dart';

void main() {
  test(
    'Query was trimmed for the NewsApi and other arguments was not changed',
    () async {
      final api = NewsApiFake(() => Stream.value(const {'status': 'ok'}));

      final repository = NewsRepositoryImpl(api);

      final query = '    query';
      final page = 1;
      final pageSize = 10;

      await repository
          .getNewsByQuery(query: query, page: page, pageSize: pageSize)
          .first;

      expect(query.trim(), api.query);
      expect(page, api.pageIndex);
      expect(pageSize, api.pageSize);
    },
  );

  test('NewsApi returns OK status and one article and NewsResponseDto was mapped to GetNewsResultSuccess', () async {
    const articleTitle = 'Title';
    final api = NewsApiFake(
      () => Stream.value(const {
        'status': 'ok',
        'articles': [
          {'title': articleTitle},
        ],
      }),
    );

    final repository = NewsRepositoryImpl(api);
    final response = await repository
        .getNewsByQuery(query: 'query', page: 1, pageSize: 10)
        .first;

    expect(
      response,
      const GetNewsResult.success(
        articles: [ArticleModel(title: articleTitle)],
      ),
    );
  });

  test(
    'NewsApi returns error status and code was mapped to GetNewsError',
    () async {
      final api = NewsApiFake(() {
        return Stream.value(const {
          'status': 'error',
          'code': 'apiKeyDisabled',
        });
      });

      final repository = NewsRepositoryImpl(api);
      final response = await repository
          .getNewsByQuery(query: 'query', page: 1, pageSize: 10)
          .first;

      expect(
        response,
        const GetNewsResult.failure(error: GetNewsError.apiKeyDisabled()),
      );
    },
  );

  test('NewsApi returns error status as 200 response and code was mapped to GetNewsError', () async {
    final api = NewsApiFake(
      () => Stream.value(const {'status': 'error', 'code': 'apiKeyDisabled'}),
    );

    final repository = NewsRepositoryImpl(api);
    final response = await repository
        .getNewsByQuery(query: 'query', page: 1, pageSize: 10)
        .first;

    expect(
      response,
      const GetNewsResult.failure(error: GetNewsError.apiKeyDisabled()),
    );
  });

  test(
    'NewsApi returns nothing and code was mapped to GetNewsErrorUnexpected',
    () async {
      final api = NewsApiFake(
        () => Stream.error(const EmptyResponseException()),
      );

      final repository = NewsRepositoryImpl(api);
      final response = await repository
          .getNewsByQuery(query: 'query', page: 1, pageSize: 10)
          .first;

      expect(
        response,
        const GetNewsResult.failure(error: GetNewsError.unexpected()),
      );
    },
  );

  test(
    'NewsApi returns wrong JSON and code was mapped to GetNewsErrorUnexpected',
    () async {
      final api = NewsApiFake(() => Stream.value({'wrong_body': 'error'}));

      final repository = NewsRepositoryImpl(api);
      final response = await repository
          .getNewsByQuery(query: 'query', page: 1, pageSize: 10)
          .first;

      expect(
        response,
        const GetNewsResult.failure(error: GetNewsError.unexpected()),
      );
    },
  );

  test('Dio returns non DioException and code was mapped to GetNewsErrorUnexpected', () async {
    final api = NewsApiFake(() {
      return Stream.error(Exception('Not DioException'));
    });

    final repository = NewsRepositoryImpl(api);
    final response = await repository
        .getNewsByQuery(query: 'query', page: 1, pageSize: 10)
        .first;

    expect(
      response,
      const GetNewsResult.failure(error: GetNewsError.unexpected()),
    );
  });

  test(
    'Someone cancels the subscription and repository emits nothing',
    () async {
      final api = NewsApiFake(
        () => Stream.fromFuture(Completer<Map<String, dynamic>>().future),
      );

      final repository = NewsRepositoryImpl(api);
      final events = <GetNewsResult>[];
      final subscription = repository
          .getNewsByQuery(query: 'query', page: 1, pageSize: 10)
          .listen(events.add);

      await pumpEventQueue();
      await subscription.cancel();

      expect(events, isEmpty);
    },
  );
}
