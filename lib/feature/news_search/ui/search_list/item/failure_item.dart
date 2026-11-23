import 'package:material_ui/material_ui.dart';
import 'package:news_shower/common/ui/app_localizations_ext.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_error.dart';

class SearchListFailureItem extends StatelessWidget {
  final NewsListError _error;
  final VoidCallback _onRetryPressed;

  const SearchListFailureItem({
    super.key,
    required this._error,
    required this._onRetryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return switch (_error) {
      NewsListErrorApiKeyDisabled() => _SearchListNotRetryableErrorItem(
        title: context.l10n.errorApiKeyDisabled,
      ),
      NewsListErrorApiKeyExhausted() => _SearchListNotRetryableErrorItem(
        title: context.l10n.errorApiKeyExhausted,
      ),
      NewsListErrorApiKeyInvalid() => _SearchListNotRetryableErrorItem(
        title: context.l10n.errorApiKeyInvalid,
      ),
      NewsListErrorApiKeyMissing() => _SearchListNotRetryableErrorItem(
        title: context.l10n.errorApiKeyMissing,
      ),
      NewsListErrorMaximumResultsReached() => _SearchListNotRetryableErrorItem(
        title: context.l10n.errorMaximumResultsReached,
      ),
      NewsListErrorRateLimited() => _SearchListRetryableErrorItem(
        title: context.l10n.errorTooManyRequest,
        onRetryPressed: _onRetryPressed,
      ),
      NewsListErrorUnexpected() => _SearchListRetryableErrorItem(
        title: context.l10n.errorUnexpected,
        onRetryPressed: _onRetryPressed,
      ),
    };
  }
}

class _SearchListRetryableErrorItem extends StatelessWidget {
  final String title;
  final VoidCallback onRetryPressed;

  const _SearchListRetryableErrorItem({
    super.key,
    required this.title,
    required this.onRetryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SearchListErrorTitle(title: title),

        const SizedBox(height: 8),
        _SearchListErrorRetryButton(onPressed: onRetryPressed),
      ],
    );
  }
}

class _SearchListNotRetryableErrorItem extends StatelessWidget {
  final String title;

  const _SearchListNotRetryableErrorItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return _SearchListErrorTitle(title: title);
  }
}

class _SearchListErrorTitle extends StatelessWidget {
  final String title;

  const _SearchListErrorTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge,
      textAlign: TextAlign.center,
    );
  }
}

class _SearchListErrorRetryButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SearchListErrorRetryButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(context.l10n.errorButton),
    );
  }
}
