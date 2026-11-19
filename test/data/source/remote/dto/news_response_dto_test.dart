import 'package:flutter_test/flutter_test.dart';
import 'package:news_shower/data/source/remote/dto/news_response_dto.dart';

void main() {
  test('Parse JSON to NewsResponseDto', () {
    final dto = NewsResponseDto.fromJson({
      'status': 'ok',
      'articles': [
        {
          'title': 'Title',
          'description': 'Description',
          'publishedAt': '2026-11-19T12:00:00Z',
          'urlToImage': 'https://example.com/image.png',
          'url': 'https://example.com',
          'source': {'name': 'Example'},
        },
      ],
    });

    expect(
      dto,
      const NewsResponseDto(
        status: 'ok',
        articles: [
          ArticleDto(
            title: 'Title',
            description: 'Description',
            publishedAt: '2026-11-19T12:00:00Z',
            urlToImage: 'https://example.com/image.png',
            url: 'https://example.com',
            source: ArticleSourceDto(name: 'Example'),
          ),
        ],
      ),
    );
  });
}
