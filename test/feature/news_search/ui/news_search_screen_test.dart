import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:news_shower/feature/news_search/controller/news_search_controller.dart';
import 'package:news_shower/feature/news_search/ui/news_search_screen.dart';

import '../../../common/ui/pump_screen.dart';

void main() {
  testWidgets('Search button disabled before a query', (tester) async {
    final controller = NewsSearchController();

    await pumpScreen(tester, NewsSearchScreen(controller: controller));

    FilledButton button = tester.widget<FilledButton>(
      find.byType(FilledButton),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets('Search button enabled after a query', (tester) async {
    final controller = NewsSearchController();

    await pumpScreen(tester, NewsSearchScreen(controller: controller));

    FilledButton button = tester.widget<FilledButton>(
      find.byType(FilledButton),
    );

    await tester.enterText(find.byType(TextField), 'flutter');
    await tester.pump();

    button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Search button disable after a blank query', (tester) async {
    final controller = NewsSearchController();

    await pumpScreen(tester, NewsSearchScreen(controller: controller));

    FilledButton button = tester.widget<FilledButton>(
      find.byType(FilledButton),
    );

    await tester.enterText(find.byType(TextField), '      ');
    await tester.pump();

    button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNull);
  });

  testWidgets(
    'List screen is opened after search button tapped with query text',
    (tester) async {
      final controller = NewsSearchController();

      await pumpScreen(tester, NewsSearchScreen(controller: controller));

      await tester.enterText(find.byType(TextField), 'query');
      await tester.pump();

      await tester.tap(find.widgetWithText(FilledButton, 'Найти'));
      await tester.pumpAndSettle();

      expect(find.text('route:query'), findsOneWidget);
    },
  );

  testWidgets(
    'List screen is opened after search button tapped with trimmed query text',
    (tester) async {
      final controller = NewsSearchController();

      await pumpScreen(tester, NewsSearchScreen(controller: controller));

      await tester.enterText(find.byType(TextField), '     query   ');
      await tester.pump();

      await tester.tap(find.widgetWithText(FilledButton, 'Найти'));
      await tester.pumpAndSettle();

      expect(find.text('route:query'), findsOneWidget);
    },
  );

  testWidgets(
    'List screen is opened after ime search action with trimmed query text',
    (tester) async {
      final controller = NewsSearchController();

      await pumpScreen(tester, NewsSearchScreen(controller: controller));

      await tester.enterText(find.byType(TextField), '     query  ');
      await tester.pump();

      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pumpAndSettle();

      expect(find.text('route:query'), findsOneWidget);
    },
  );

  testWidgets(
    'List screen is not opened after ime search action without query text',
    (tester) async {
      final controller = NewsSearchController();

      await pumpScreen(tester, NewsSearchScreen(controller: controller));

      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pumpAndSettle();

      expect(find.text('route:query'), findsNothing);
    },
  );

  testWidgets('List screen is opened only once after ime search action', (
    tester,
  ) async {
    final controller = NewsSearchController();

    await pumpScreen(tester, NewsSearchScreen(controller: controller));

    await tester.enterText(find.byType(TextField), '     query  ');
    await tester.pump();

    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    expect(find.text('route:query'), findsOneWidget);
  });

  testWidgets('List screen is opened after returning from list', (
    tester,
  ) async {
    final controller = NewsSearchController();

    await pumpScreen(tester, NewsSearchScreen(controller: controller));

    final navigator = tester.state<NavigatorState>(find.byType(Navigator));

    await tester.enterText(find.byType(TextField), '     query  ');
    await tester.pump();

    await tester.tap(find.widgetWithText(FilledButton, 'Найти'));
    await tester.pumpAndSettle();
    expect(find.text('route:query'), findsOneWidget);

    navigator.pop();
    await tester.pumpAndSettle();
    expect(find.text('route:query'), findsNothing);

    await tester.tap(find.widgetWithText(FilledButton, 'Найти'));
    await tester.pumpAndSettle();
    expect(find.text('route:query'), findsOneWidget);
  });
}
