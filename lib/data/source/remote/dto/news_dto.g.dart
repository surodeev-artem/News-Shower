// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NewsResponseDto _$NewsResponseDtoFromJson(Map<String, dynamic> json) =>
    _NewsResponseDto(
      status: json['status'] as String,
      totalResults: (json['totalResults'] as num?)?.toInt(),
      articles: (json['articles'] as List<dynamic>?)
          ?.map((e) => ArticleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: json['code'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$NewsResponseDtoToJson(_NewsResponseDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
      'code': instance.code,
      'message': instance.message,
    };

_ArticleDto _$ArticleDtoFromJson(Map<String, dynamic> json) => _ArticleDto(
  title: json['title'] as String?,
  description: json['description'] as String?,
  publishedAt: json['publishedAt'] as String?,
  urlToImage: json['urlToImage'] as String?,
  url: json['url'] as String?,
  source: json['source'] == null
      ? null
      : ArticleSourceDto.fromJson(json['source'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ArticleDtoToJson(_ArticleDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'publishedAt': instance.publishedAt,
      'urlToImage': instance.urlToImage,
      'url': instance.url,
      'source': instance.source,
    };

_ArticleSourceDto _$ArticleSourceDtoFromJson(Map<String, dynamic> json) =>
    _ArticleSourceDto(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$ArticleSourceDtoToJson(_ArticleSourceDto instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
