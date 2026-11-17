import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_dto.freezed.dart';
part 'news_dto.g.dart';

@freezed
abstract class NewsResponseDto with _$NewsResponseDto {
  const factory NewsResponseDto({
    required String status,
    // Status: ok
    int? totalResults,
    List<ArticleDto>? articles,
    // Status: error
    String? code,
    String? message,
  }) = _NewsResponseDto;

  factory NewsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseDtoFromJson(json);
}

@freezed
abstract class ArticleDto with _$ArticleDto {
  const factory ArticleDto({
    String? title,
    String? description,
    String? publishedAt,
    String? urlToImage,
    String? url,
    ArticleSourceDto? source,
  }) = _ArticleDto;

  factory ArticleDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleDtoFromJson(json);
}

@freezed
abstract class ArticleSourceDto with _$ArticleSourceDto {
  const factory ArticleSourceDto({required String id, required String name}) =
      _ArticleSourceDto;

  factory ArticleSourceDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleSourceDtoFromJson(json);
}
