import 'package:dio/dio.dart';
import 'package:news_shower/data/source/remote/dto/news_dto.dart';
import 'package:news_shower/data/source/remote/news_api.dart';
import 'package:news_shower/domain/model/get_news_error.dart';
import 'package:news_shower/domain/model/get_news_result.dart';
import 'package:news_shower/domain/model/news_model.dart';
import 'package:news_shower/domain/repository/news_repository.dart';

const String _responseStatusOk = 'ok';

class NewsRepositoryImpl implements NewsRepository {
  final NewsApi _newsApi;

  NewsRepositoryImpl(this._newsApi);

  @override
  Stream<GetNewsResult> getNewsByQuery(String query) async* {
    try {
      NewsResponseDto result = await _newsApi.getNewsByQuery(query, 1, 10);
      if (result.status == _responseStatusOk) {
        yield GetNewsResult.success(
          NewsModel(
            result.articles?.map((newsItem) {
                  return ArticleModel(
                    newsItem.title,
                    newsItem.description,
                    _parsePublishedAt(newsItem.publishedAt),
                    newsItem.urlToImage,
                    newsItem.url,
                    newsItem.source?.name,
                  );
                }).toList() ??
                List.empty(),
          ),
        );
      } else {
        yield GetNewsResult.failure(_parseError(result));
      }
    } on DioException catch (e) {
      if (e.response?.data is Map) {
        final result = NewsResponseDto.fromJson(
          Map<String, dynamic>.from(e.response?.data),
        );
        yield GetNewsResult.failure(_parseError(result));
      } else {
        yield GetNewsResult.failure(GetNewsError.unexpected());
      }
    } catch (e) {
      yield GetNewsResult.failure(GetNewsError.unexpected());
    }
  }

  DateTime? _parsePublishedAt(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return DateTime.tryParse(value);
  }

  GetNewsError _parseError(NewsResponseDto response) {
    return switch (response.code) {
      'apiKeyDisabled' => GetNewsError.apiKeyDisabled(),
      'apiKeyExhausted' => GetNewsError.apiKeyExhausted(),
      'apiKeyInvalid' => GetNewsError.apiKeyInvalid(),
      'apiKeyMissing' => GetNewsError.apiKeyMissing(),
      'rateLimited' => GetNewsError.rateLimited(),
      _ => GetNewsError.unexpected(),
    };
  }
}
