import 'package:material_ui/material_ui.dart';
import 'package:news_shower/common/ui/app_localizations_ext.dart';

class SearchListDateHeader extends StatelessWidget {
  final DateTime _date;

  const SearchListDateHeader({super.key, required this._date});

  @override
  Widget build(BuildContext context) {
    final today = DateUtils.dateOnly(DateTime.now());
    String dateTitle = _date == today
        ? context.l10n.today
        : _date == today.subtract(const Duration(days: 1))
        ? context.l10n.yesterday
        : context.l10n.publishedAtHeader(_date);

    return Padding(
      key: key,
      padding: const EdgeInsetsGeometry.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 8,
      ),
      child: Text(dateTitle, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
