import 'package:material_ui/material_ui.dart';
import 'package:news_shower/common/ui/app_localizations_ext.dart';

class SearchListEmptyState extends StatelessWidget {
  const SearchListEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: SizedBox.expand(
        child: Center(
          child: Text(
            context.l10n.newsNotFound,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
