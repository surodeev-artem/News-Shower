import 'package:flutter_test/flutter_test.dart';
import 'package:news_shower/data/source/remote/dto/news_response_dto.dart';
import 'package:news_shower/data/source/remote/dto/news_response_dto_mapper.dart';
import 'package:news_shower/domain/model/get_news_error.dart';
import 'package:news_shower/domain/model/get_news_result.dart';

void main() {
  group('NewsResponseDto status is OK', () {
    test(
      'Maps articles when status is OK and all fields is not empty or null',
      () {
        const responseStatus = 'ok';
        const articleTitle = 'Title';
        const articleDescription = 'Description';
        const articlePublishedAt = '2026-11-19T12:00:00Z';
        const articleUrlToImage = 'https://example.com/image.png';
        const articleUrl = 'https://example.com';
        const articleSource = 'Example';

        final dto = const NewsResponseDto(
          status: responseStatus,
          articles: [
            ArticleDto(
              title: articleTitle,
              description: articleDescription,
              publishedAt: articlePublishedAt,
              urlToImage: articleUrlToImage,
              url: articleUrl,
              source: ArticleSourceDto(name: articleSource),
            ),
          ],
        );

        final mappingResult = NewsResponseDtoMapper.map(dto);

        expect(mappingResult, isA<GetNewsResultSuccess>());
        final articles = (mappingResult as GetNewsResultSuccess).articles;

        expect(articles, hasLength(1));
        expect(articles.single.title, articleTitle);
        expect(articles.single.description, articleDescription);
        expect(articles.single.publishedAt, DateTime.parse(articlePublishedAt));
        expect(articles.single.urlToImage, articleUrlToImage);
        expect(articles.single.url, articleUrl);
        expect(articles.single.source, articleSource);
      },
    );

    test(
      'Maps articles when status is OK and all fields of article is null',
      () {
        const responseStatus = 'ok';

        final dto = const NewsResponseDto(
          status: responseStatus,
          articles: [
            ArticleDto(
              title: null,
              description: null,
              publishedAt: null,
              urlToImage: null,
              url: null,
              source: null,
            ),
          ],
        );

        final mappingResult = NewsResponseDtoMapper.map(dto);

        expect(mappingResult, isA<GetNewsResultSuccess>());
        final articles = (mappingResult as GetNewsResultSuccess).articles;

        expect(articles, hasLength(1));
        expect(articles.single.title, isNull);
        expect(articles.single.description, isNull);
        expect(articles.single.publishedAt, isNull);
        expect(articles.single.urlToImage, isNull);
        expect(articles.single.url, isNull);
        expect(articles.single.source, isNull);
      },
    );

    test(
      'Maps articles when status is OK and all fields of article is empty',
      () {
        const responseStatus = 'ok';

        final dto = const NewsResponseDto(
          status: responseStatus,
          articles: [
            ArticleDto(
              title: '',
              description: '',
              publishedAt: '',
              urlToImage: '',
              url: '',
              source: ArticleSourceDto(name: ''),
            ),
          ],
        );

        final mappingResult = NewsResponseDtoMapper.map(dto);

        expect(mappingResult, isA<GetNewsResultSuccess>());
        final articles = (mappingResult as GetNewsResultSuccess).articles;

        expect(articles, hasLength(1));
        expect(articles.single.title, '');
        expect(articles.single.description, '');
        expect(articles.single.publishedAt, isNull);
        expect(articles.single.urlToImage, '');
        expect(articles.single.url, '');
        expect(articles.single.source, '');
      },
    );

    test('Maps articles when status is OK and source name field is null', () {
      const responseStatus = 'ok';

      final dto = const NewsResponseDto(
        status: responseStatus,
        articles: [
          ArticleDto(
            title: '',
            description: '',
            publishedAt: '',
            urlToImage: '',
            url: '',
            source: ArticleSourceDto(name: null),
          ),
        ],
      );

      final mappingResult = NewsResponseDtoMapper.map(dto);

      expect(mappingResult, isA<GetNewsResultSuccess>());
      final articles = (mappingResult as GetNewsResultSuccess).articles;

      expect(articles, hasLength(1));
      expect(articles.single.source, isNull);
    });

    test('Maps articles when status is OK and articles field is null', () {
      const responseStatus = 'ok';

      final dto = const NewsResponseDto(status: responseStatus, articles: null);

      final mappingResult = NewsResponseDtoMapper.map(dto);

      expect(mappingResult, isA<GetNewsResultSuccess>());
      final articles = (mappingResult as GetNewsResultSuccess).articles;

      expect(articles, hasLength(0));
    });
  });

  group('NewsResponseDto status is not OK', () {
    for (final errorCode in {
      'maximumResultsReached': const GetNewsError.maximumResultsReached(),
      'apiKeyDisabled': const GetNewsError.apiKeyDisabled(),
      'apiKeyExhausted': const GetNewsError.apiKeyExhausted(),
      'apiKeyInvalid': const GetNewsError.apiKeyInvalid(),
      'apiKeyMissing': const GetNewsError.apiKeyMissing(),
      'rateLimited': const GetNewsError.rateLimited(),
      'randomCode': const GetNewsError.unexpected(),
    }.entries) {
      test(
        'Maps error when status is Error and error code is ${errorCode.key}',
        () {
          final dto = NewsResponseDto(status: 'error', code: errorCode.key);

          final mappingResult = NewsResponseDtoMapper.map(dto);

          expect(mappingResult, GetNewsResult.failure(error: errorCode.value));
        },
      );
    }
  });
}
