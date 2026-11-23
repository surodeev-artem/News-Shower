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
        .map((response) {
          final dto = NewsResponseDto.fromJson(response);
          return NewsResponseDtoMapper.map(dto);
        })
        .onErrorResume(
          (_, _) => Stream.value(
            const GetNewsResult.failure(error: GetNewsError.unexpected()),
          ),
        );
  }
}
