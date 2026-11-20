import 'package:flutter_test/flutter_test.dart';
import 'package:news_shower/domain/model/article_model.dart';
import 'package:news_shower/feature/news_search/controller/model/article.dart';
import 'package:news_shower/feature/news_search/controller/model/article_model_mapper.dart';

void main() {
  group('Maps ArticleModel to Article', () {
    test(
      'Maps ArticleModel to Article when all fields is not empty and null',
      () {
        const articleTitle = 'Title';
        const articleDescription = 'Description';
        const articleUrlToImage = 'https://example.com/image.png';
        const articleUrl = 'https://example.com';
        const articleSource = 'Example';

        DateTime articlePublishedAt = DateTime.parse('2026-11-19T12:00:00Z');

        final model = ArticleModel(
          title: articleTitle,
          description: articleDescription,
          publishedAt: articlePublishedAt,
          urlToImage: articleUrlToImage,
          url: articleUrl,
          source: articleSource,
        );

        final article = ArticleModelMapper.map(model);

        expect(article, isA<Article>());
        expect(article.title, articleTitle);
        expect(article.description, articleDescription);
        expect(article.publishedAt, articlePublishedAt.toLocal());
        expect(article.urlToImage, articleUrlToImage);
        expect(article.url, articleUrl);
        expect(article.source, articleSource);
      },
    );

    test('Maps ArticleModel to Article when all fields is empty and publishedAt is not null', () {
      DateTime articlePublishedAt = DateTime.parse('2026-11-19T12:00:00Z');

      final model = ArticleModel(
        title: '',
        description: '',
        publishedAt: articlePublishedAt,
        urlToImage: '',
        url: '',
        source: '',
      );

      final article = ArticleModelMapper.map(model);

      expect(article, isA<Article>());
      expect(article.title, '');
      expect(article.description, '');
      expect(article.publishedAt, articlePublishedAt.toLocal());
      expect(article.urlToImage, '');
      expect(article.url, '');
      expect(article.source, '');
    });

    test('Maps ArticleModel to Article when all fields is null', () {
      final model = const ArticleModel(
        title: null,
        description: null,
        publishedAt: null,
        urlToImage: null,
        url: null,
        source: null,
      );

      final article = ArticleModelMapper.map(model);

      expect(article, isA<Article>());
      expect(article.title, isNull);
      expect(article.description, isNull);
      expect(article.publishedAt, isNull);
      expect(article.urlToImage, isNull);
      expect(article.url, isNull);
      expect(article.source, isNull);
    });
  });
}
