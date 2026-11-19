import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';

@freezed
abstract class Article with _$Article {
  const factory Article({
    String? title,
    String? description,
    DateTime? publishedAt,
    String? urlToImage,
    String? url,
    String? source,
  }) = _Article;
}
