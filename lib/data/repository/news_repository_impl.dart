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
      NewsResponseDto result = await _newsApi.getNewsByQuery(query, 0, 10);
      if (result.status == _responseStatusOk) {
        yield GetNewsResult.success(
          NewsModel(
            result.articles
                    ?.map(
                      (newsItem) => NewsItemModel(
                        newsItem.title,
                        newsItem.description,
                        newsItem.publishedAt,
                        newsItem.urlToImage,
                        newsItem.url,
                        newsItem.title,
                      ),
                    )
                    .toList() ??
                List.empty(),
          ),
        );
      } else {
        yield GetNewsResult.failure(parseError(result));
      }
    } on DioException catch (e) {
      if (e.response?.data is Map) {
        final result = NewsResponseDto.fromJson(
          Map<String, dynamic>.from(e.response?.data),
        );
        yield GetNewsResult.failure(parseError(result));
      } else {
        yield GetNewsResult.failure(GetNewsError.unexpected());
      }
    }
  }

  GetNewsError parseError(NewsResponseDto response) {
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
