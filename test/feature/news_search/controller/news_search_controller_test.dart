import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:news_shower/domain/model/article_model.dart';
import 'package:news_shower/domain/model/get_news_error.dart';
import 'package:news_shower/domain/model/get_news_result.dart';
import 'package:news_shower/feature/news_search/controller/model/article_model_mapper.dart';
import 'package:news_shower/feature/news_search/controller/model/get_news_error_mapper.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_error.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_state.dart';
import 'package:news_shower/feature/news_search/controller/model/news_search_effect.dart';
import 'package:news_shower/feature/news_search/controller/news_search_controller.dart';

import '../../../common/domain/link_launcher_fake.dart';
import '../../../data/repository/news_repository_fake.dart';

void main() {
  test('Search button is disabled on initial state', () {
    final controller = NewsSearchController(
      NewsRepositoryFake(const []),
      LinkLauncherFake(() async => true),
    );

    expect(controller.state.isSearchButtonEnabled, false);

    addTearDown(controller.dispose);
  });

  test('Search button is disabled when user typed blank query', () {
    final controller = NewsSearchController(
      NewsRepositoryFake(const []),
      LinkLauncherFake(() async => true),
    );

    controller.onSearchQueryChanged('    ');

    expect(controller.state.isSearchButtonEnabled, false);

    addTearDown(controller.dispose);
  });

  test('Search button is enabled when user typed non blank query', () {
    final controller = NewsSearchController(
      NewsRepositoryFake(const []),
      LinkLauncherFake(() async => true),
    );

    controller.onSearchQueryChanged('query');

    expect(controller.state.isSearchButtonEnabled, true);

    addTearDown(controller.dispose);
  });

  test(
    'Search button is disabled when user typed non blank query and erase it',
    () async {
      final controller = NewsSearchController(
        NewsRepositoryFake(const []),
        LinkLauncherFake(() async => true),
      );

      controller.onSearchQueryChanged('query');
      controller.onSearchQueryChanged('     ');

      expect(controller.state.isSearchButtonEnabled, false);

      addTearDown(controller.dispose);
    },
  );

  test(
    'Nothing happen when tap on search button when query is empty',
    () async {
      final repository = NewsRepositoryFake(const []);

      final controller = NewsSearchController(
        repository,
        LinkLauncherFake(() async => true),
      );

      controller.onSearchButtonPressed('');

      expect(repository.calls, 0);
      expect(controller.state.isSearchButtonEnabled, false);

      addTearDown(controller.dispose);
    },
  );

  test(
    'Nothing happen when tap on search button when query is blank',
    () async {
      final repository = NewsRepositoryFake(const []);

      final controller = NewsSearchController(
        repository,
        LinkLauncherFake(() async => true),
      );

      controller.onSearchButtonPressed('    ');

      expect(repository.calls, 0);
      expect(controller.state.isSearchButtonEnabled, false);

      addTearDown(controller.dispose);
    },
  );

  test('Use trimmed query when tap on search button with query', () async {
    final repository = NewsRepositoryFake(const [
      GetNewsResult.success(articles: []),
    ]);

    final controller = NewsSearchController(
      repository,
      LinkLauncherFake(() async => true),
    );

    controller.onSearchQueryChanged('    query  ');

    final loaded = _waitUntil(
      controller,
      (state) => state is! NewsListStateLoading && state is! NewsListStateInit,
    );

    controller.onSearchButtonPressed('    query  ');

    await loaded;

    expect(controller.state.query, 'query');
    expect(controller.state.isSearchButtonEnabled, true);
    expect(controller.state.listState, const NewsListState.empty());
    expect(repository.calls, 1);

    addTearDown(controller.dispose);
  });

  test(
    'Repository calls once when double tap on search button with query',
    () async {
      final repository = NewsRepositoryFake(const [
        GetNewsResult.success(articles: []),
        GetNewsResult.success(articles: []),
      ]);
      final controller = NewsSearchController(
        repository,
        LinkLauncherFake(() async => true),
      );

      controller.onSearchQueryChanged('query');

      controller.onSearchButtonPressed('query');
      controller.onSearchButtonPressed('query');

      await pumpEventQueue();

      expect(repository.calls, 1);
      expect(controller.state.isSearchButtonEnabled, true);

      addTearDown(controller.dispose);
    },
  );

  test('State is NewsListStateInit before first loading', () {
    final repository = NewsRepositoryFake(const []);
    final linkLauncher = LinkLauncherFake(() async => true);
    final controller = NewsSearchController(repository, linkLauncher);

    expect(controller.state.listState, const NewsListState.init());

    addTearDown(() => controller.dispose());
  });

  test('State is NewsListStateEmpty after first empty loading data', () async {
    final repository = NewsRepositoryFake(const [
      GetNewsResult.success(articles: []),
    ]);
    final linkLauncher = LinkLauncherFake(() async => true);
    final controller = NewsSearchController(repository, linkLauncher);

    final firstNotLoadingStateNotifier = _waitUntil(
      controller,
      (state) => state is! NewsListStateLoading && state is! NewsListStateInit,
    );
    controller.load();

    await firstNotLoadingStateNotifier;
    expect(controller.state.listState, const NewsListState.empty());

    addTearDown(() => controller.dispose());
  });

  test(
    'State is NewsListStateFailure after first failure loading data',
    () async {
      final response = const GetNewsResult.failure(
        error: GetNewsError.apiKeyMissing(),
      );
      final repository = NewsRepositoryFake([response]);
      final linkLauncher = LinkLauncherFake(() async => true);
      final controller = NewsSearchController(repository, linkLauncher);

      final firstNotLoadingStateNotifier = _waitUntil(
        controller,
        (state) =>
            state is! NewsListStateLoading && state is! NewsListStateInit,
      );
      controller.load();

      await firstNotLoadingStateNotifier;

      expect(
        controller.state.listState,
        NewsListState.failure(
          error: GetNewsErrorMapper.map(
            (response as GetNewsResultFailure).error,
          ),
        ),
      );

      addTearDown(() => controller.dispose());
    },
  );

  test('State is NewsListStateData with articles and paging data after first non empty loading data', () async {
    final response = GetNewsResult.success(
      articles: List.filled(20, const ArticleModel(title: 'Title')),
    );
    final repository = NewsRepositoryFake([response]);
    final linkLauncher = LinkLauncherFake(() async => true);
    final controller = NewsSearchController(repository, linkLauncher);

    final firstNotLoadingStateNotifier = _waitUntil(
      controller,
      (state) => state is! NewsListStateLoading && state is! NewsListStateInit,
    );
    controller.load();

    await firstNotLoadingStateNotifier;

    expect(controller.state.listState, isA<NewsListStateData>());
    final state = controller.state.listState as NewsListStateData;
    expect(
      state.articles,
      (response as GetNewsResultSuccess).articles
          .map(ArticleModelMapper.map)
          .toList(),
    );
    expect(state.page, 1);
    expect(state.hasReachedEnd, false);
    expect(state.isLoadingMore, false);
    expect(state.loadMoreError, isNull);

    addTearDown(() => controller.dispose());
  });

  test('State is NewsListStateData loading with articles and paging data after second loading', () async {
    final firstResponse = GetNewsResult.success(
      articles: List.filled(20, const ArticleModel(title: 'Title first')),
    );
    final secondResponse = GetNewsResult.success(
      articles: List.filled(20, const ArticleModel(title: 'Title second')),
    );
    final responses = [firstResponse, secondResponse];
    final repository = NewsRepositoryFake(responses);
    final linkLauncher = LinkLauncherFake(() async => true);
    final controller = NewsSearchController(repository, linkLauncher);

    final firstNotLoadingStateNotifier = _waitUntil(
      controller,
      (state) => state is! NewsListStateLoading && state is! NewsListStateInit,
    );
    controller.load();

    await firstNotLoadingStateNotifier;

    final secondLoadingStateNotifier = _waitUntil(
      controller,
      (state) => state is NewsListStateData && state.isLoadingMore,
    );
    controller.load();

    await secondLoadingStateNotifier;

    expect(controller.state.listState, isA<NewsListStateData>());
    final state = controller.state.listState as NewsListStateData;
    expect(
      state.articles,
      (responses[0] as GetNewsResultSuccess).articles
          .map(ArticleModelMapper.map)
          .toList(),
    );
    expect(state.page, 1);
    expect(state.hasReachedEnd, false);
    expect(state.isLoadingMore, true);
    expect(state.loadMoreError, isNull);

    addTearDown(() => controller.dispose());
  });

  test('State is NewsListStateData failure with articles and paging data after second failure loading', () async {
    final firstResponse = GetNewsResult.success(
      articles: List.filled(20, const ArticleModel(title: 'Title first')),
    );
    final secondResponse = const GetNewsResult.failure(
      error: GetNewsError.apiKeyDisabled(),
    );
    final responses = [firstResponse, secondResponse];
    final repository = NewsRepositoryFake(responses);
    final linkLauncher = LinkLauncherFake(() async => true);
    final controller = NewsSearchController(repository, linkLauncher);

    final firstNotLoadingStateNotifier = _waitUntil(
      controller,
      (state) => state is! NewsListStateLoading && state is! NewsListStateInit,
    );
    controller.load();

    await firstNotLoadingStateNotifier;

    final secondFailureStateNotifier = _waitUntil(
      controller,
      (state) => state is NewsListStateData && state.loadMoreError != null,
    );
    controller.load();

    await secondFailureStateNotifier;

    expect(controller.state.listState, isA<NewsListStateData>());
    final state = controller.state.listState as NewsListStateData;
    expect(
      state.articles,
      (responses[0] as GetNewsResultSuccess).articles
          .map(ArticleModelMapper.map)
          .toList(),
    );
    expect(state.page, 1);
    expect(state.hasReachedEnd, false);
    expect(state.isLoadingMore, false);
    expect(state.loadMoreError, const NewsListError.apiKeyDisabled());

    addTearDown(() => controller.dispose());
  });

  test('State is NewsListStateData failure with articles and paging data after second failure with maximumResultsReached loading', () async {
    final firstResponse = GetNewsResult.success(
      articles: List.filled(20, const ArticleModel(title: 'Title first')),
    );
    final secondResponse = const GetNewsResult.failure(
      error: GetNewsError.maximumResultsReached(),
    );
    final responses = [firstResponse, secondResponse];
    final repository = NewsRepositoryFake(responses);
    final linkLauncher = LinkLauncherFake(() async => true);
    final controller = NewsSearchController(repository, linkLauncher);

    final firstNotLoadingStateNotifier = _waitUntil(
      controller,
      (state) => state is! NewsListStateLoading && state is! NewsListStateInit,
    );
    controller.load();

    await firstNotLoadingStateNotifier;

    final secondFailureStateNotifier = _waitUntil(
      controller,
      (state) => state is NewsListStateData && state.loadMoreError != null,
    );
    controller.load();

    await secondFailureStateNotifier;

    expect(controller.state.listState, isA<NewsListStateData>());
    final state = controller.state.listState as NewsListStateData;
    expect(
      state.articles,
      (responses[0] as GetNewsResultSuccess).articles
          .map(ArticleModelMapper.map)
          .toList(),
    );
    expect(state.page, 1);
    expect(state.hasReachedEnd, true);
    expect(state.isLoadingMore, false);
    expect(state.loadMoreError, const NewsListError.maximumResultsReached());

    addTearDown(() => controller.dispose());
  });

  test('State is NewsListStateData hasReachedEnd with articles and paging data after second not fully loading', () async {
    final firstResponse = GetNewsResult.success(
      articles: List.filled(20, const ArticleModel(title: 'Title first')),
    );
    final secondResponse = GetNewsResult.success(
      articles: List.filled(10, const ArticleModel(title: 'Title second')),
    );
    final responses = [firstResponse, secondResponse];
    final repository = NewsRepositoryFake(responses);
    final linkLauncher = LinkLauncherFake(() async => true);
    final controller = NewsSearchController(repository, linkLauncher);

    final firstNotLoadingStateNotifier = _waitUntil(
      controller,
      (state) => state is! NewsListStateLoading && state is! NewsListStateInit,
    );
    controller.load();

    await firstNotLoadingStateNotifier;

    final secondFailureStateNotifier = _waitUntil(
      controller,
      (state) =>
          state is NewsListStateData && state.page == 2 && !state.isLoadingMore,
    );
    controller.load();

    await secondFailureStateNotifier;

    expect(controller.state.listState, isA<NewsListStateData>());
    final state = controller.state.listState as NewsListStateData;
    expect(
      state.articles,
      responses
          .map(
            (response) => (response as GetNewsResultSuccess).articles
                .map(ArticleModelMapper.map)
                .toList(),
          )
          .expand((response) => response)
          .toList(),
    );
    expect(state.page, 2);
    expect(state.hasReachedEnd, true);
    expect(state.isLoadingMore, false);
    expect(state.loadMoreError, null);

    addTearDown(() => controller.dispose());
  });

  test('State is NewsListStateData with articles and paging data after second non empty loading', () async {
    final firstResponse = GetNewsResult.success(
      articles: List.filled(20, const ArticleModel(title: 'Title first')),
    );
    final secondResponse = GetNewsResult.success(
      articles: List.filled(20, const ArticleModel(title: 'Title second')),
    );
    final responses = [firstResponse, secondResponse];
    final repository = NewsRepositoryFake(responses);
    final linkLauncher = LinkLauncherFake(() async => true);
    final controller = NewsSearchController(repository, linkLauncher);

    final firstNotLoadingStateNotifier = _waitUntil(
      controller,
      (state) => state is! NewsListStateLoading && state is! NewsListStateInit,
    );
    controller.load();

    await firstNotLoadingStateNotifier;

    final secondNotLoadingStateNotifier = _waitUntil(
      controller,
      (state) => state is NewsListStateData && !state.isLoadingMore,
    );
    controller.load();

    await secondNotLoadingStateNotifier;

    expect(controller.state.listState, isA<NewsListStateData>());
    final state = controller.state.listState as NewsListStateData;
    expect(
      state.articles,
      responses
          .map(
            (response) => (response as GetNewsResultSuccess).articles
                .map(ArticleModelMapper.map)
                .toList(),
          )
          .expand((response) => response)
          .toList(),
    );
    expect(state.page, 2);
    expect(state.hasReachedEnd, false);
    expect(state.isLoadingMore, false);
    expect(state.loadMoreError, isNull);

    addTearDown(() => controller.dispose());
  });

  test('Double loading calls only single repository call', () async {
    final firstResponse = GetNewsResult.success(
      articles: List.filled(20, const ArticleModel(title: 'Title first')),
    );
    final secondResponse = GetNewsResult.success(
      articles: List.filled(20, const ArticleModel(title: 'Title second')),
    );
    final responses = [firstResponse, secondResponse];
    final repository = NewsRepositoryFake(responses);
    final linkLauncher = LinkLauncherFake(() async => true);
    final controller = NewsSearchController(repository, linkLauncher);

    final firstNotLoadingStateNotifier = _waitUntil(
      controller,
      (state) => state is! NewsListStateLoading && state is! NewsListStateInit,
    );
    controller.load();
    controller.load();

    await firstNotLoadingStateNotifier;

    await pumpEventQueue();
    expect(controller.state.listState, isA<NewsListStateData>());
    final state = controller.state.listState as NewsListStateData;
    expect(
      state.articles,
      (responses[0] as GetNewsResultSuccess).articles
          .map(ArticleModelMapper.map)
          .toList(),
    );
    expect(state.page, 1);
    expect(state.hasReachedEnd, false);
    expect(state.isLoadingMore, false);
    expect(state.loadMoreError, isNull);
    expect(repository.calls, 1);

    addTearDown(() => controller.dispose());
  });

  test('Click on article with valid url opens browser', () async {
    final repository = NewsRepositoryFake(const []);
    final linkLauncher = LinkLauncherFake(() async => true);
    final controller = NewsSearchController(repository, linkLauncher);

    final url = 'https://example.com/';
    final uri = Uri.parse(url);

    final effects = <NewsSearchEffect>[];
    final subscription = controller.effect.listen(effects.add);
    controller.onArticlePressed(url);

    await pumpEventQueue();
    subscription.cancel();

    expect(effects, isEmpty);
    expect(linkLauncher.openedUris.single, uri);
    addTearDown(() => controller.dispose());
  });

  test('Click on article with url without schema not opens browser', () async {
    final repository = NewsRepositoryFake(const []);
    final linkLauncher = LinkLauncherFake(() async => false);
    final controller = NewsSearchController(repository, linkLauncher);

    final url = 'example.com/';

    final effects = <NewsSearchEffect>[];
    final subscription = controller.effect.listen(effects.add);
    controller.onArticlePressed(url);

    await pumpEventQueue();
    subscription.cancel();

    expect(effects.single, const NewsSearchEffect.articleUrlIsNotValid());
    expect(linkLauncher.openedUris, isEmpty);
    addTearDown(() => controller.dispose());
  });

  test(
    'Click on article with url not http/https schema not opens browser',
    () async {
      final repository = NewsRepositoryFake(const []);
      final linkLauncher = LinkLauncherFake(() async => false);
      final controller = NewsSearchController(repository, linkLauncher);

      final url = 'file://example.com/';

      final effects = <NewsSearchEffect>[];
      final subscription = controller.effect.listen(effects.add);
      controller.onArticlePressed(url);

      await pumpEventQueue();
      subscription.cancel();

      expect(effects.single, const NewsSearchEffect.articleUrlIsNotValid());
      expect(linkLauncher.openedUris, isEmpty);
      addTearDown(() => controller.dispose());
    },
  );

  test('Click on article with empty url not opens browser', () async {
    final repository = NewsRepositoryFake(const []);
    final linkLauncher = LinkLauncherFake(() async => false);
    final controller = NewsSearchController(repository, linkLauncher);

    final url = '';

    final effects = <NewsSearchEffect>[];
    final subscription = controller.effect.listen(effects.add);
    controller.onArticlePressed(url);

    await pumpEventQueue();
    subscription.cancel();

    expect(effects.single, const NewsSearchEffect.articleUrlIsNotValid());
    expect(linkLauncher.openedUris, isEmpty);
    addTearDown(() => controller.dispose());
  });

  test(
    'Click on article and link launcher throws error not opens browser',
    () async {
      final repository = NewsRepositoryFake(const []);
      final linkLauncher = LinkLauncherFake(
        () async => throw Exception('Wrong url'),
      );
      final controller = NewsSearchController(repository, linkLauncher);

      final url = 'https://example.com/';

      final effects = <NewsSearchEffect>[];
      final subscription = controller.effect.listen(effects.add);
      controller.onArticlePressed(url);

      await pumpEventQueue();
      subscription.cancel();

      expect(effects.single, const NewsSearchEffect.articleUrlIsNotValid());
      expect(linkLauncher.openedUris, isEmpty);
      addTearDown(() => controller.dispose());
    },
  );

  test(
    'Click on article and link launcher returns false not opens browser',
    () async {
      final repository = NewsRepositoryFake(const []);
      final linkLauncher = LinkLauncherFake(() async => false);
      final controller = NewsSearchController(repository, linkLauncher);

      final url = 'https://example.com/';

      final effects = <NewsSearchEffect>[];
      final subscription = controller.effect.listen(effects.add);
      controller.onArticlePressed(url);

      await pumpEventQueue();
      subscription.cancel();

      expect(effects.single, const NewsSearchEffect.articleUrlIsNotValid());
      expect(linkLauncher.openedUris, isEmpty);
      addTearDown(() => controller.dispose());
    },
  );
}

Future<void> _waitUntil(
  NewsSearchController controller,
  bool Function(NewsListState state) ready,
) {
  final completer = Completer<void>();
  void listener() {
    if (!completer.isCompleted && ready(controller.state.listState)) {
      completer.complete();
    }
  }

  controller.addListener(listener);
  return completer.future.whenComplete(
    () => controller.removeListener(listener),
  );
}
