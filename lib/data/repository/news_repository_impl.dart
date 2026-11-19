import 'package:dio/dio.dart';
import 'package:news_shower/data/source/remote/dto/news_response_dto.dart';
import 'package:news_shower/data/source/remote/dto/news_response_dto_mapper.dart';
import 'package:news_shower/data/source/remote/news_api.dart';
import 'package:news_shower/domain/model/get_news_error.dart';
import 'package:news_shower/domain/model/get_news_result.dart';
import 'package:news_shower/domain/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsApi _newsApi;

  NewsRepositoryImpl(this._newsApi);

  @override
  Stream<GetNewsResult> getNewsByQuery({
    required String query,
    required int page,
    required int pageSize,
  }) {
    return Stream<GetNewsResult>.multi((listener) {
      final cancelToken = CancelToken();
      var cancelled = false;
      listener.onCancel = () {
        cancelled = true;
        if (!cancelToken.isCancelled) cancelToken.cancel();
      };
      _load(query, page, pageSize, cancelToken).then((result) {
        if (cancelled || !listener.hasListener) return;
        listener.add(result);
        listener.close();
      });
    });
  }

  Future<GetNewsResult> _load(
    String query,
    int page,
    int pageSize,
    CancelToken cancelToken,
  ) async {
    try {
      final response = await _newsApi.getNewsByQuery(
        query.trim(),
        page,
        pageSize,
        cancelToken,
      );

      return NewsResponseDtoMapper.map(response);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        return const GetNewsResult.failure(error: GetNewsError.unexpected());
      }
      if (e.response?.data is Map) {
        try {
          final response = NewsResponseDto.fromJson(
            Map<String, dynamic>.from(e.response?.data),
          );
          return NewsResponseDtoMapper.map(response);
        } catch (e) {
          return const GetNewsResult.failure(error: GetNewsError.unexpected());
        }
      } else {
        return const GetNewsResult.failure(error: GetNewsError.unexpected());
      }
    } catch (e) {
      return const GetNewsResult.failure(error: GetNewsError.unexpected());
    }
  }
}
