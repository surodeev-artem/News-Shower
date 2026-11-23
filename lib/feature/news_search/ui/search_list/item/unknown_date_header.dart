import 'package:material_ui/material_ui.dart';
import 'package:news_shower/common/ui/app_localizations_ext.dart';

class SearchListUnknownDateHeader extends StatelessWidget {
  const SearchListUnknownDateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: key,
      padding: const EdgeInsetsGeometry.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 8,
      ),
      child: Text(
        context.l10n.unknownDate,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
