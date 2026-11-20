import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:news_shower/common/ui/app_localizations_ext.dart';
import 'package:news_shower/domain/model/article_model.dart';
import 'package:news_shower/domain/model/get_news_error.dart';
import 'package:news_shower/domain/model/get_news_result.dart';
import 'package:news_shower/feature/news_list/controller/news_list_controller.dart';
import 'package:news_shower/feature/news_list/ui/news_list_screen.dart';

import '../../../common/domain/link_launcher_fake.dart';
import '../../../common/ui/pump_screen.dart';
import '../../../data/repository/news_repository_fake.dart';

void main() {
  testWidgets('Query was applied from parameters on AppBar title', (
    tester,
  ) async {
    const query = 'Query';
    final newsRepository = NewsRepositoryFake(const [
      GetNewsResult.success(articles: []),
    ]);
    final linkLauncher = LinkLauncherFake(() async => true);
    final controller = NewsListController(newsRepository, linkLauncher, query);

    await pumpScreen(
      tester,
      NewsListScreen(controller: controller, query: query),
    );

    expect(find.widgetWithText(AppBar, query), findsOneWidget);
  });

  testWidgets('News not found shown if result is empty', (tester) async {
    const query = 'Query';
    final newsRepository = NewsRepositoryFake(const [
      GetNewsResult.success(articles: []),
    ]);
    final linkLauncher = LinkLauncherFake(() async => true);
    final controller = NewsListController(newsRepository, linkLauncher, query);

    await pumpScreen(
      tester,
      NewsListScreen(controller: controller, query: query),
    );

    final context = tester.element(find.byType(NewsListScreen));

    await tester.pump();

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
      final controller = NewsListController(
        newsRepository,
        linkLauncher,
        query,
      );

      await pumpScreen(
        tester,
        NewsListScreen(controller: controller, query: query),
      );

      final context = tester.element(find.byType(NewsListScreen));

      await tester.pump();

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
    final controller = NewsListController(newsRepository, linkLauncher, query);

    await pumpScreen(
      tester,
      NewsListScreen(controller: controller, query: query),
    );

    final context = tester.element(find.byType(NewsListScreen));

    await tester.pump();

    expect(find.text(context.l10n.errorApiKeyDisabled), findsOneWidget);
    expect(find.text(context.l10n.errorButton), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Article shown if result is success', (tester) async {
    const query = 'Query';
    final newsRepository = NewsRepositoryFake(const [
      GetNewsResult.success(
        articles: [ArticleModel(title: 'Title', description: 'Description')],
      ),
    ]);
    final linkLauncher = LinkLauncherFake(() async => true);
    final controller = NewsListController(newsRepository, linkLauncher, query);

    await pumpScreen(
      tester,
      NewsListScreen(controller: controller, query: query),
    );

    final context = tester.element(find.byType(NewsListScreen));

    await tester.pump();

    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
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
    final controller = NewsListController(newsRepository, linkLauncher, query);

    await pumpScreen(
      tester,
      NewsListScreen(controller: controller, query: query),
    );

    await tester.pump();

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
      final controller = NewsListController(
        newsRepository,
        linkLauncher,
        query,
      );

      await pumpScreen(
        tester,
        NewsListScreen(controller: controller, query: query),
      );

      final context = tester.element(find.byType(NewsListScreen));

      await tester.pump();

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
      ]);
      final linkLauncher = LinkLauncherFake(() async => true);
      final controller = NewsListController(
        newsRepository,
        linkLauncher,
        query,
      );

      await pumpScreen(
        tester,
        NewsListScreen(controller: controller, query: query),
      );

      final context = tester.element(find.byType(NewsListScreen));

      await tester.pump();

      expect(find.text(context.l10n.errorButton), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      await tester.scrollUntilVisible(
        find.text('Title 19'),
        300,
        scrollable: find.byType(Scrollable),
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
