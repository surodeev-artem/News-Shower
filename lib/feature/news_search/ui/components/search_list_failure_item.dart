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
      NewsListErrorApiKeyDisabled() => _NotRetryableErrorItem(
        title: context.l10n.errorApiKeyDisabled,
      ),
      NewsListErrorApiKeyExhausted() => _NotRetryableErrorItem(
        title: context.l10n.errorApiKeyExhausted,
      ),
      NewsListErrorApiKeyInvalid() => _NotRetryableErrorItem(
        title: context.l10n.errorApiKeyInvalid,
      ),
      NewsListErrorApiKeyMissing() => _NotRetryableErrorItem(
        title: context.l10n.errorApiKeyMissing,
      ),
      NewsListErrorMaximumResultsReached() => _NotRetryableErrorItem(
        title: context.l10n.errorMaximumResultsReached,
      ),
      NewsListErrorRateLimited() => _RetryableErrorItem(
        title: context.l10n.errorTooManyRequest,
        onRetryPressed: _onRetryPressed,
      ),
      NewsListErrorUnexpected() => _RetryableErrorItem(
        title: context.l10n.errorUnexpected,
        onRetryPressed: _onRetryPressed,
      ),
    };
  }
}

class _RetryableErrorItem extends StatelessWidget {
  final String title;
  final VoidCallback onRetryPressed;

  const _RetryableErrorItem({
    super.key,
    required this.title,
    required this.onRetryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ErrorTitle(title: title),

        const SizedBox(height: 8),
        _ErrorRetryButton(onPressed: onRetryPressed),
      ],
    );
  }
}

class _NotRetryableErrorItem extends StatelessWidget {
  final String title;

  const _NotRetryableErrorItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return _ErrorTitle(title: title);
  }
}

class _ErrorTitle extends StatelessWidget {
  final String title;

  const _ErrorTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge,
      textAlign: TextAlign.center,
    );
  }
}

class _ErrorRetryButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ErrorRetryButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(context.l10n.errorButton),
    );
  }
}
