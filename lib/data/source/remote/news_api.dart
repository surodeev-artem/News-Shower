import 'package:news_shower/data/source/remote/dto/news_response_dto.dart';

abstract class NewsApi {
  Stream<NewsResponseDto> getNewsByQuery(
    String query,
    int pageIndex,
    int pageSize,
  );
}
