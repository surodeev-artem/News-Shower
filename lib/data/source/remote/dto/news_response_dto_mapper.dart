import 'package:news_shower/data/source/remote/dto/news_response_dto.dart';
import 'package:news_shower/domain/model/article_model.dart';
import 'package:news_shower/domain/model/get_news_error.dart';
import 'package:news_shower/domain/model/get_news_result.dart';

const String _responseStatusOk = 'ok';

final class NewsResponseDtoMapper {
  static GetNewsResult map(NewsResponseDto response) {
    if (response.status == _responseStatusOk) {
      return GetNewsResult.success(
        articles: response.articles?.map(_mapArticle).toList() ?? const [],
      );
    } else {
      return GetNewsResult.failure(error: _mapError(response));
    }
  }

  static ArticleModel _mapArticle(ArticleDto articleDto) {
    return ArticleModel(
      title: articleDto.title,
      description: articleDto.description,
      publishedAt: _parsePublishedAt(articleDto.publishedAt),
      urlToImage: articleDto.urlToImage,
      url: articleDto.url,
      source: articleDto.source?.name,
    );
  }

  static DateTime? _parsePublishedAt(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return DateTime.tryParse(value);
  }

  static GetNewsError _mapError(NewsResponseDto response) {
    return switch (response.code) {
      'maximumResultsReached' => const GetNewsError.maximumResultsReached(),
      'apiKeyDisabled' => const GetNewsError.apiKeyDisabled(),
      'apiKeyExhausted' => const GetNewsError.apiKeyExhausted(),
      'apiKeyInvalid' => const GetNewsError.apiKeyInvalid(),
      'apiKeyMissing' => const GetNewsError.apiKeyMissing(),
      'rateLimited' => const GetNewsError.rateLimited(),
      _ => const GetNewsError.unexpected(),
    };
  }
}
