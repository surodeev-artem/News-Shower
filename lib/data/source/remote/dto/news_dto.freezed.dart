// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NewsResponseDto {

 String get status; int? get totalResults; List<ArticleDto>? get articles; String? get code; String? get message;
/// Create a copy of NewsResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsResponseDtoCopyWith<NewsResponseDto> get copyWith => _$NewsResponseDtoCopyWithImpl<NewsResponseDto>(this as NewsResponseDto, _$identity);

  /// Serializes this NewsResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NewsResponseDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsResponseDto&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.totalResults, _this.totalResults) || other.totalResults == _this.totalResults)&&const DeepCollectionEquality().equals(other.articles, _this.articles)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NewsResponseDto;
  return Object.hash(runtimeType,_this.status,_this.totalResults,const DeepCollectionEquality().hash(_this.articles),_this.code,_this.message);
}

@override
String toString() {
  final _this = this as NewsResponseDto;
  return 'NewsResponseDto(status: ${_this.status}, totalResults: ${_this.totalResults}, articles: ${_this.articles}, code: ${_this.code}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $NewsResponseDtoCopyWith<$Res>  {
  factory $NewsResponseDtoCopyWith(NewsResponseDto value, $Res Function(NewsResponseDto) _then) = _$NewsResponseDtoCopyWithImpl;
@useResult
$Res call({
 String status, int? totalResults, List<ArticleDto>? articles, String? code, String? message
});




}
/// @nodoc
class _$NewsResponseDtoCopyWithImpl<$Res>
    implements $NewsResponseDtoCopyWith<$Res> {
  _$NewsResponseDtoCopyWithImpl(this._self, this._then);

  final NewsResponseDto _self;
  final $Res Function(NewsResponseDto) _then;

/// Create a copy of NewsResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? totalResults = freezed,Object? articles = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(NewsResponseDto(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalResults: freezed == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as int?,articles: freezed == articles ? _self.articles : articles // ignore: cast_nullable_to_non_nullable
as List<ArticleDto>?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NewsResponseDto].
extension NewsResponseDtoPatterns on NewsResponseDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewsResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewsResponseDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewsResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _NewsResponseDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewsResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _NewsResponseDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  int? totalResults,  List<ArticleDto>? articles,  String? code,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewsResponseDto() when $default != null:
return $default(_that.status,_that.totalResults,_that.articles,_that.code,_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  int? totalResults,  List<ArticleDto>? articles,  String? code,  String? message)  $default,) {final _that = this;
switch (_that) {
case _NewsResponseDto():
return $default(_that.status,_that.totalResults,_that.articles,_that.code,_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  int? totalResults,  List<ArticleDto>? articles,  String? code,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _NewsResponseDto() when $default != null:
return $default(_that.status,_that.totalResults,_that.articles,_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewsResponseDto implements NewsResponseDto {
  const _NewsResponseDto({required this.status, this.totalResults,  List<ArticleDto>? articles, this.code, this.message}): _articles = articles;
  factory _NewsResponseDto.fromJson(Map<String, dynamic> json) => _$NewsResponseDtoFromJson(json);

@override final  String status;
@override final  int? totalResults;
 final  List<ArticleDto>? _articles;
@override List<ArticleDto>? get articles {
  final value = _articles;
  if (value == null) return null;
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? code;
@override final  String? message;

/// Create a copy of NewsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsResponseDtoCopyWith<_NewsResponseDto> get copyWith => __$NewsResponseDtoCopyWithImpl<_NewsResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewsResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsResponseDto&&(identical(other.status, status) || other.status == status)&&(identical(other.totalResults, totalResults) || other.totalResults == totalResults)&&const DeepCollectionEquality().equals(other.articles, _articles)&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,totalResults,const DeepCollectionEquality().hash(_articles),code,message);
}

@override
String toString() {
    return 'NewsResponseDto(status: $status, totalResults: $totalResults, articles: $articles, code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$NewsResponseDtoCopyWith<$Res> implements $NewsResponseDtoCopyWith<$Res> {
  factory _$NewsResponseDtoCopyWith(_NewsResponseDto value, $Res Function(_NewsResponseDto) _then) = __$NewsResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String status, int? totalResults, List<ArticleDto>? articles, String? code, String? message
});




}
/// @nodoc
class __$NewsResponseDtoCopyWithImpl<$Res>
    implements _$NewsResponseDtoCopyWith<$Res> {
  __$NewsResponseDtoCopyWithImpl(this._self, this._then);

  final _NewsResponseDto _self;
  final $Res Function(_NewsResponseDto) _then;

/// Create a copy of NewsResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? totalResults = freezed,Object? articles = freezed,Object? code = freezed,Object? message = freezed,}) {
  return _then(_NewsResponseDto(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalResults: freezed == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as int?,articles: freezed == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<ArticleDto>?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ArticleDto {

 String? get title; String? get description; String? get publishedAt; String? get urlToImage; String? get url; ArticleSourceDto? get source;
/// Create a copy of ArticleDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleDtoCopyWith<ArticleDto> get copyWith => _$ArticleDtoCopyWithImpl<ArticleDto>(this as ArticleDto, _$identity);

  /// Serializes this ArticleDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ArticleDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleDto&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.publishedAt, _this.publishedAt) || other.publishedAt == _this.publishedAt)&&(identical(other.urlToImage, _this.urlToImage) || other.urlToImage == _this.urlToImage)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.source, _this.source) || other.source == _this.source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ArticleDto;
  return Object.hash(runtimeType,_this.title,_this.description,_this.publishedAt,_this.urlToImage,_this.url,_this.source);
}

@override
String toString() {
  final _this = this as ArticleDto;
  return 'ArticleDto(title: ${_this.title}, description: ${_this.description}, publishedAt: ${_this.publishedAt}, urlToImage: ${_this.urlToImage}, url: ${_this.url}, source: ${_this.source})';
}


}

/// @nodoc
abstract mixin class $ArticleDtoCopyWith<$Res>  {
  factory $ArticleDtoCopyWith(ArticleDto value, $Res Function(ArticleDto) _then) = _$ArticleDtoCopyWithImpl;
@useResult
$Res call({
 String? title, String? description, String? publishedAt, String? urlToImage, String? url, ArticleSourceDto? source
});


$ArticleSourceDtoCopyWith<$Res>? get source;

}
/// @nodoc
class _$ArticleDtoCopyWithImpl<$Res>
    implements $ArticleDtoCopyWith<$Res> {
  _$ArticleDtoCopyWithImpl(this._self, this._then);

  final ArticleDto _self;
  final $Res Function(ArticleDto) _then;

/// Create a copy of ArticleDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? description = freezed,Object? publishedAt = freezed,Object? urlToImage = freezed,Object? url = freezed,Object? source = freezed,}) {
  return _then(ArticleDto(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String?,urlToImage: freezed == urlToImage ? _self.urlToImage : urlToImage // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ArticleSourceDto?,
  ));
}
/// Create a copy of ArticleDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleSourceDtoCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $ArticleSourceDtoCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// Adds pattern-matching-related methods to [ArticleDto].
extension ArticleDtoPatterns on ArticleDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleDto value)  $default,){
final _that = this;
switch (_that) {
case _ArticleDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleDto value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  String? description,  String? publishedAt,  String? urlToImage,  String? url,  ArticleSourceDto? source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleDto() when $default != null:
return $default(_that.title,_that.description,_that.publishedAt,_that.urlToImage,_that.url,_that.source);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  String? description,  String? publishedAt,  String? urlToImage,  String? url,  ArticleSourceDto? source)  $default,) {final _that = this;
switch (_that) {
case _ArticleDto():
return $default(_that.title,_that.description,_that.publishedAt,_that.urlToImage,_that.url,_that.source);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  String? description,  String? publishedAt,  String? urlToImage,  String? url,  ArticleSourceDto? source)?  $default,) {final _that = this;
switch (_that) {
case _ArticleDto() when $default != null:
return $default(_that.title,_that.description,_that.publishedAt,_that.urlToImage,_that.url,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArticleDto implements ArticleDto {
  const _ArticleDto({this.title, this.description, this.publishedAt, this.urlToImage, this.url, this.source});
  factory _ArticleDto.fromJson(Map<String, dynamic> json) => _$ArticleDtoFromJson(json);

@override final  String? title;
@override final  String? description;
@override final  String? publishedAt;
@override final  String? urlToImage;
@override final  String? url;
@override final  ArticleSourceDto? source;

/// Create a copy of ArticleDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleDtoCopyWith<_ArticleDto> get copyWith => __$ArticleDtoCopyWithImpl<_ArticleDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleDto&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.urlToImage, urlToImage) || other.urlToImage == urlToImage)&&(identical(other.url, url) || other.url == url)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,title,description,publishedAt,urlToImage,url,source);
}

@override
String toString() {
    return 'ArticleDto(title: $title, description: $description, publishedAt: $publishedAt, urlToImage: $urlToImage, url: $url, source: $source)';
}


}

/// @nodoc
abstract mixin class _$ArticleDtoCopyWith<$Res> implements $ArticleDtoCopyWith<$Res> {
  factory _$ArticleDtoCopyWith(_ArticleDto value, $Res Function(_ArticleDto) _then) = __$ArticleDtoCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? description, String? publishedAt, String? urlToImage, String? url, ArticleSourceDto? source
});


@override $ArticleSourceDtoCopyWith<$Res>? get source;

}
/// @nodoc
class __$ArticleDtoCopyWithImpl<$Res>
    implements _$ArticleDtoCopyWith<$Res> {
  __$ArticleDtoCopyWithImpl(this._self, this._then);

  final _ArticleDto _self;
  final $Res Function(_ArticleDto) _then;

/// Create a copy of ArticleDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? description = freezed,Object? publishedAt = freezed,Object? urlToImage = freezed,Object? url = freezed,Object? source = freezed,}) {
  return _then(_ArticleDto(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String?,urlToImage: freezed == urlToImage ? _self.urlToImage : urlToImage // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ArticleSourceDto?,
  ));
}

/// Create a copy of ArticleDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleSourceDtoCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $ArticleSourceDtoCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// @nodoc
mixin _$ArticleSourceDto {

 String? get name;
/// Create a copy of ArticleSourceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleSourceDtoCopyWith<ArticleSourceDto> get copyWith => _$ArticleSourceDtoCopyWithImpl<ArticleSourceDto>(this as ArticleSourceDto, _$identity);

  /// Serializes this ArticleSourceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ArticleSourceDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleSourceDto&&(identical(other.name, _this.name) || other.name == _this.name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ArticleSourceDto;
  return Object.hash(runtimeType,_this.name);
}

@override
String toString() {
  final _this = this as ArticleSourceDto;
  return 'ArticleSourceDto(name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $ArticleSourceDtoCopyWith<$Res>  {
  factory $ArticleSourceDtoCopyWith(ArticleSourceDto value, $Res Function(ArticleSourceDto) _then) = _$ArticleSourceDtoCopyWithImpl;
@useResult
$Res call({
 String? name
});




}
/// @nodoc
class _$ArticleSourceDtoCopyWithImpl<$Res>
    implements $ArticleSourceDtoCopyWith<$Res> {
  _$ArticleSourceDtoCopyWithImpl(this._self, this._then);

  final ArticleSourceDto _self;
  final $Res Function(ArticleSourceDto) _then;

/// Create a copy of ArticleSourceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,}) {
  return _then(ArticleSourceDto(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticleSourceDto].
extension ArticleSourceDtoPatterns on ArticleSourceDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleSourceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleSourceDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleSourceDto value)  $default,){
final _that = this;
switch (_that) {
case _ArticleSourceDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleSourceDto value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleSourceDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleSourceDto() when $default != null:
return $default(_that.name);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name)  $default,) {final _that = this;
switch (_that) {
case _ArticleSourceDto():
return $default(_that.name);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name)?  $default,) {final _that = this;
switch (_that) {
case _ArticleSourceDto() when $default != null:
return $default(_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArticleSourceDto implements ArticleSourceDto {
  const _ArticleSourceDto({this.name});
  factory _ArticleSourceDto.fromJson(Map<String, dynamic> json) => _$ArticleSourceDtoFromJson(json);

@override final  String? name;

/// Create a copy of ArticleSourceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleSourceDtoCopyWith<_ArticleSourceDto> get copyWith => __$ArticleSourceDtoCopyWithImpl<_ArticleSourceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleSourceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleSourceDto&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name);
}

@override
String toString() {
    return 'ArticleSourceDto(name: $name)';
}


}

/// @nodoc
abstract mixin class _$ArticleSourceDtoCopyWith<$Res> implements $ArticleSourceDtoCopyWith<$Res> {
  factory _$ArticleSourceDtoCopyWith(_ArticleSourceDto value, $Res Function(_ArticleSourceDto) _then) = __$ArticleSourceDtoCopyWithImpl;
@override @useResult
$Res call({
 String? name
});




}
/// @nodoc
class __$ArticleSourceDtoCopyWithImpl<$Res>
    implements _$ArticleSourceDtoCopyWith<$Res> {
  __$ArticleSourceDtoCopyWithImpl(this._self, this._then);

  final _ArticleSourceDto _self;
  final $Res Function(_ArticleSourceDto) _then;

/// Create a copy of ArticleSourceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,}) {
  return _then(_ArticleSourceDto(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
