import 'package:flutter_test/flutter_test.dart';
import 'package:news_shower/feature/news_search/controller/model/news_search_effect.dart';
import 'package:news_shower/feature/news_search/controller/news_search_controller.dart';

void main() {
  test('Search button is disabled on initial state', () {
    final controller = NewsSearchController();

    expect(controller.state.isSearchButtonEnabled, false);

    addTearDown(controller.dispose);
  });

  test('Search button is disabled when user typed blank query', () {
    final controller = NewsSearchController();

    controller.onSearchQueryChanged('    ');

    expect(controller.state.isSearchButtonEnabled, false);

    addTearDown(controller.dispose);
  });

  test('Search button is enabled when user typed non blank query', () {
    final controller = NewsSearchController();

    controller.onSearchQueryChanged('query');

    expect(controller.state.isSearchButtonEnabled, true);

    addTearDown(controller.dispose);
  });

  test(
    'Search button is disabled when user typed non blank query and erase it',
    () {
      final controller = NewsSearchController();

      controller.onSearchQueryChanged('query');
      controller.onSearchQueryChanged('     ');

      expect(controller.state.isSearchButtonEnabled, false);

      addTearDown(controller.dispose);
    },
  );

  test('Nothing happen when tap on search button when query is empty', () {
    final controller = NewsSearchController();

    final effects = <NewsSearchEffect>[];
    controller.effect.listen(effects.add);

    controller.onSearchButtonPressed('');

    expect(effects, isEmpty);
    expect(controller.state.isSearchButtonEnabled, false);

    addTearDown(controller.dispose);
  });

  test(
    'Nothing happen when tap on search button when query is blank',
    () async {
      final controller = NewsSearchController();

      controller.onSearchQueryChanged('     ');
      final effects = <NewsSearchEffect>[];
      controller.effect.listen(effects.add);

      controller.onSearchButtonPressed('     ');

      await pumpEventQueue();

      expect(effects, isEmpty);
      expect(controller.state.isSearchButtonEnabled, false);

      addTearDown(controller.dispose);
    },
  );

  test('NewsSearchEffectGoToList emits with trimmed query when tap on search button with query', () async {
    final controller = NewsSearchController();

    controller.onSearchQueryChanged('    query');
    final effects = <NewsSearchEffect>[];
    controller.effect.listen(effects.add);

    controller.onSearchButtonPressed('    query');

    await pumpEventQueue();

    expect(effects, hasLength(1));
    expect(effects.single, const NewsSearchEffect.goToList(query: 'query'));
    expect(controller.state.isSearchButtonEnabled, true);

    addTearDown(controller.dispose);
  });

  test('NewsSearchEffectGoToList emits once when double tap on search button with query', () async {
    final controller = NewsSearchController();

    controller.onSearchQueryChanged('query');
    final effects = <NewsSearchEffect>[];
    controller.effect.listen(effects.add);

    controller.onSearchButtonPressed('query');
    controller.onSearchButtonPressed('second query');

    await pumpEventQueue();

    expect(effects, hasLength(1));
    expect(effects.single, const NewsSearchEffect.goToList(query: 'query'));
    expect(controller.state.isSearchButtonEnabled, true);

    addTearDown(controller.dispose);
  });

  test(
    'NewsSearchEffectGoToList emits twice after returning from list',
    () async {
      final controller = NewsSearchController();

      controller.onSearchQueryChanged('query');
      final effects = <NewsSearchEffect>[];
      controller.effect.listen(effects.add);

      controller.onSearchButtonPressed('query');
      controller.onReturnedFromList();
      controller.onSearchButtonPressed('second query');

      await pumpEventQueue();

      expect(effects, hasLength(2));
      expect(effects[0], const NewsSearchEffect.goToList(query: 'query'));
      expect(
        effects[1],
        const NewsSearchEffect.goToList(query: 'second query'),
      );
      expect(controller.state.isSearchButtonEnabled, true);

      addTearDown(controller.dispose);
    },
  );
}
