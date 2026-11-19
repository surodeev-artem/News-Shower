import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_model.freezed.dart';

@freezed
abstract class ArticleModel with _$ArticleModel {
  const factory ArticleModel({
    String? title,
    String? description,
    DateTime? publishedAt,
    String? urlToImage,
    String? url,
    String? source,
  }) = _ArticleModel;
}
