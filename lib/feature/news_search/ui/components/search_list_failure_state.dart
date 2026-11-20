import 'package:flutter/widgets.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_error.dart';
import 'package:news_shower/feature/news_search/ui/components/search_list_failure_item.dart';

class SearchListFailureState extends StatelessWidget {
  final NewsListError _error;
  final VoidCallback _onRetryPressed;

  const SearchListFailureState({
    super.key,
    required this._error,
    required this._onRetryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(16),
          child: Center(
            child: SearchListFailureItem(
              error: _error,
              onRetryPressed: _onRetryPressed,
            ),
          ),
        ),
      ),
    );
  }
}
