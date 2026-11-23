import 'package:dio/dio.dart';
import 'package:news_shower/data/source/remote/dto/news_response_dto.dart';
import 'package:news_shower/data/source/remote/dto/news_response_dto_mapper.dart';
import 'package:news_shower/data/source/remote/news_api.dart';
import 'package:news_shower/domain/model/get_news_error.dart';
import 'package:news_shower/domain/model/get_news_result.dart';
import 'package:news_shower/domain/repository/news_repository.dart';
import 'package:rxdart/rxdart.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsApi _newsApi;

  NewsRepositoryImpl(this._newsApi);

  @override
  Stream<GetNewsResult> getNewsByQuery({
    required String query,
    required int page,
    required int pageSize,
  }) {
    return _newsApi
        .getNewsByQuery(query.trim(), page, pageSize)
        .map((response) => NewsResponseDtoMapper.map(response))
        .onErrorResume((e, _) {
          if (e is DioException && CancelToken.isCancel(e)) {
            return const Stream.empty();
          }

          final data = e is DioException ? e.response?.data : null;
          if (data is Map) {
            try {
              final response = NewsResponseDto.fromJson(
                Map<String, dynamic>.from(data),
              );
              return Stream.value(NewsResponseDtoMapper.map(response));
            } catch (e) {
              return Stream.value(
                const GetNewsResult.failure(error: GetNewsError.unexpected()),
              );
            }
          }

          return Stream.value(
            const GetNewsResult.failure(error: GetNewsError.unexpected()),
          );
        });
  }
}
