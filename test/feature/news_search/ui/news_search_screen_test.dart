import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:news_shower/common/ui/app_localizations_ext.dart';
import 'package:news_shower/domain/model/article_model.dart';
import 'package:news_shower/domain/model/get_news_error.dart';
import 'package:news_shower/domain/model/get_news_result.dart';
import 'package:news_shower/feature/news_search/controller/news_search_controller.dart';
import 'package:news_shower/feature/news_search/ui/news_search_screen.dart';

import '../../../common/domain/link_launcher_fake.dart';
import '../../../common/ui/pump_screen.dart';
import '../../../data/repository/news_repository_fake.dart';

void main() {
  testWidgets('Search button disabled before a query', (tester) async {
    final controller = NewsSearchController(
      NewsRepositoryFake(const []),
      LinkLauncherFake(() async => true),
    );

    await pumpScreen(tester, NewsSearchScreen(controller: controller));

    IconButton button = tester.widget<IconButton>(find.byType(IconButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('Search button enabled after a query', (tester) async {
    final controller = NewsSearchController(
      NewsRepositoryFake(const []),
      LinkLauncherFake(() async => true),
    );

    await pumpScreen(tester, NewsSearchScreen(controller: controller));

    IconButton button = tester.widget<IconButton>(find.byType(IconButton));

    await tester.enterText(find.byType(TextField), 'query');
    await tester.pump();

    button = tester.widget<IconButton>(find.byType(IconButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Search button disable after a blank query', (tester) async {
    final controller = NewsSearchController(
      NewsRepositoryFake(const []),
      LinkLauncherFake(() async => true),
    );

    await pumpScreen(tester, NewsSearchScreen(controller: controller));

    IconButton button = tester.widget<IconButton>(find.byType(IconButton));

    await tester.enterText(find.byType(TextField), '      ');
    await tester.pump();

    button = tester.widget<IconButton>(find.byType(IconButton));
    expect(button.onPressed, isNull);
  });

  testWidgets(
    'List is showed after search button tapped with trimmed query text',
    (tester) async {
      final controller = NewsSearchController(
        NewsRepositoryFake(const [
          GetNewsResult.success(articles: [ArticleModel(title: 'Title')]),
        ]),
        LinkLauncherFake(() async => true),
      );

      await pumpScreen(tester, NewsSearchScreen(controller: controller));

      await tester.enterText(find.byType(TextField), '    query');
      await tester.pump();

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.byType(Card), findsOneWidget);
      expect(controller.state.query, 'query');
    },
  );

  testWidgets(
    'List is showed after ime search action with trimmed query text',
    (tester) async {
      final controller = NewsSearchController(
        NewsRepositoryFake(const [
          GetNewsResult.success(articles: [ArticleModel(title: 'Title')]),
        ]),
        LinkLauncherFake(() async => true),
      );

      await pumpScreen(tester, NewsSearchScreen(controller: controller));

      await tester.enterText(find.byType(TextField), '     query  ');
      await tester.pump();

      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pumpAndSettle();

      expect(find.byType(Card), findsOneWidget);
      expect(controller.state.query, 'query');
    },
  );

  testWidgets('List is not showed after ime search action without query text', (
    tester,
  ) async {
    final repository = NewsRepositoryFake(const [
      GetNewsResult.success(articles: []),
    ]);
    final controller = NewsSearchController(
      repository,
      LinkLauncherFake(() async => true),
    );

    await pumpScreen(tester, NewsSearchScreen(controller: controller));

    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    expect(find.byType(Card), findsNothing);
    expect(repository.calls, 0);
  });

  testWidgets('List fetch only once after ime search action', (tester) async {
    final repository = NewsRepositoryFake(const [
      GetNewsResult.success(articles: []),
      GetNewsResult.success(articles: []),
    ]);
    final controller = NewsSearchController(
      repository,
      LinkLauncherFake(() async => true),
    );

    await pumpScreen(tester, NewsSearchScreen(controller: controller));

    await tester.enterText(find.byType(TextField), '     query  ');
    await tester.pump();

    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    expect(repository.calls, 1);
  });

  testWidgets('News not found shown if result is empty', (tester) async {
    const query = 'Query';
    final newsRepository = NewsRepositoryFake(const [
      GetNewsResult.success(articles: []),
    ]);
    final linkLauncher = LinkLauncherFake(() async => true);
    final controller = NewsSearchController(newsRepository, linkLauncher);

    await pumpScreen(tester, NewsSearchScreen(controller: controller));

    final context = tester.element(find.byType(NewsSearchScreen));

    await tester.enterText(find.byType(TextField), query);
    await tester.pump();
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    expect(find.text(context.l10n.newsNotFound), findsOneWidget);
    expect(find.text(context.l10n.errorButton), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets(
    'Too many requests with retry button shown if result is rateLimited error and after tap on retry repository calls is 2',
    (tester) async {
      const query = 'Query';
      final newsRepository = NewsRepositoryFake(const [
        GetNewsResult.failure(error: GetNewsError.rateLimited()),
        GetNewsResult.failure(error: GetNewsError.rateLimited()),
      ]);
      final linkLauncher = LinkLauncherFake(() async => true);
      final controller = NewsSearchController(newsRepository, linkLauncher);

      await pumpScreen(tester, NewsSearchScreen(controller: controller));

      final context = tester.element(find.byType(NewsSearchScreen));

      await tester.enterText(find.byType(TextField), query);
      await tester.pump();
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.text(context.l10n.errorTooManyRequest), findsOneWidget);
      expect(find.text(context.l10n.errorButton), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      await tester.tap(
        find.widgetWithText(FilledButton, context.l10n.errorButton),
      );
      await tester.pump();

      expect(newsRepository.calls, 2);
      expect(find.text(context.l10n.errorTooManyRequest), findsOneWidget);
      expect(find.text(context.l10n.errorButton), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    },
  );

  testWidgets('Api key disabled shown if result is apiKeyDisabled error', (
    tester,
  ) async {
    const query = 'Query';
    final newsRepository = NewsRepositoryFake(const [
      GetNewsResult.failure(error: GetNewsError.apiKeyDisabled()),
    ]);
    final linkLauncher = LinkLauncherFake(() async => true);
    final controller = NewsSearchController(newsRepository, linkLauncher);

    await pumpScreen(tester, NewsSearchScreen(controller: controller));

    final context = tester.element(find.byType(NewsSearchScreen));

    await tester.enterText(find.byType(TextField), query);
    await tester.pump();
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    expect(find.text(context.l10n.errorApiKeyDisabled), findsOneWidget);
    expect(find.text(context.l10n.errorButton), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Tap on valid article calls link launcher', (tester) async {
    const query = 'Query';
    const url = 'https://www.example.com/';
    final newsRepository = NewsRepositoryFake(const [
      GetNewsResult.success(
        articles: [
          ArticleModel(title: 'Title', description: 'Description', url: url),
        ],
      ),
    ]);
    final linkLauncher = LinkLauncherFake(() async => true);
    final controller = NewsSearchController(newsRepository, linkLauncher);

    await pumpScreen(tester, NewsSearchScreen(controller: controller));

    await tester.enterText(find.byType(TextField), query);
    await tester.pump();
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Card));
    await tester.pump();

    expect(linkLauncher.openedUris.single, Uri.parse(url));
  });

  testWidgets(
    'Tap on invalid article not calls link launcher and snakbar shown',
    (tester) async {
      const query = 'Query';
      const url = 'example';
      final newsRepository = NewsRepositoryFake(const [
        GetNewsResult.success(
          articles: [
            ArticleModel(title: 'Title', description: 'Description', url: url),
          ],
        ),
      ]);
      final linkLauncher = LinkLauncherFake(() async => true);
      final controller = NewsSearchController(newsRepository, linkLauncher);

      await pumpScreen(tester, NewsSearchScreen(controller: controller));

      final context = tester.element(find.byType(NewsSearchScreen));

      await tester.enterText(find.byType(TextField), query);
      await tester.pump();
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Card));
      await tester.pump();

      expect(linkLauncher.openedUris, isEmpty);
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(context.l10n.errorArticleUrlInvalid), findsOneWidget);
    },
  );

  testWidgets(
    'Error show in footer if articles has and we can retry if error is rateLimited',
    (tester) async {
      const query = 'Query';
      final newsRepository = NewsRepositoryFake([
        GetNewsResult.success(
          articles: List.generate(
            20,
            (index) =>
                ArticleModel(title: 'Title $index', description: 'Description'),
          ),
        ),
        const GetNewsResult.failure(error: GetNewsError.rateLimited()),
        const GetNewsResult.failure(error: GetNewsError.rateLimited()),
      ]);
      final linkLauncher = LinkLauncherFake(() async => true);
      final controller = NewsSearchController(newsRepository, linkLauncher);

      await pumpScreen(tester, NewsSearchScreen(controller: controller));

      final context = tester.element(find.byType(NewsSearchScreen));

      await tester.enterText(find.byType(TextField), query);
      await tester.pump();
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.text(context.l10n.errorButton), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      await tester.scrollUntilVisible(
        find.text('Title 19'),
        300,
        scrollable: find.byWidgetPredicate(
          (widget) => widget is Scrollable && widget.axis == Axis.vertical,
        ),
      );
      await tester.pump();

      expect(find.text(context.l10n.errorTooManyRequest), findsOneWidget);
      expect(find.text(context.l10n.errorButton), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      expect(newsRepository.calls, 3);
    },
  );
}
