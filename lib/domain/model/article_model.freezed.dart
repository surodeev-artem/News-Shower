// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArticleModel {

 String? get title; String? get description; DateTime? get publishedAt; String? get urlToImage; String? get url; String? get source;
/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleModelCopyWith<ArticleModel> get copyWith => _$ArticleModelCopyWithImpl<ArticleModel>(this as ArticleModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ArticleModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleModel&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.publishedAt, _this.publishedAt) || other.publishedAt == _this.publishedAt)&&(identical(other.urlToImage, _this.urlToImage) || other.urlToImage == _this.urlToImage)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.source, _this.source) || other.source == _this.source));
}


@override
int get hashCode {
  final _this = this as ArticleModel;
  return Object.hash(runtimeType,_this.title,_this.description,_this.publishedAt,_this.urlToImage,_this.url,_this.source);
}

@override
String toString() {
  final _this = this as ArticleModel;
  return 'ArticleModel(title: ${_this.title}, description: ${_this.description}, publishedAt: ${_this.publishedAt}, urlToImage: ${_this.urlToImage}, url: ${_this.url}, source: ${_this.source})';
}


}

/// @nodoc
abstract mixin class $ArticleModelCopyWith<$Res>  {
  factory $ArticleModelCopyWith(ArticleModel value, $Res Function(ArticleModel) _then) = _$ArticleModelCopyWithImpl;
@useResult
$Res call({
 String? title, String? description, DateTime? publishedAt, String? urlToImage, String? url, String? source
});




}
/// @nodoc
class _$ArticleModelCopyWithImpl<$Res>
    implements $ArticleModelCopyWith<$Res> {
  _$ArticleModelCopyWithImpl(this._self, this._then);

  final ArticleModel _self;
  final $Res Function(ArticleModel) _then;

/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? description = freezed,Object? publishedAt = freezed,Object? urlToImage = freezed,Object? url = freezed,Object? source = freezed,}) {
  return _then(ArticleModel(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,urlToImage: freezed == urlToImage ? _self.urlToImage : urlToImage // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticleModel].
extension ArticleModelPatterns on ArticleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleModel value)  $default,){
final _that = this;
switch (_that) {
case _ArticleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleModel value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  String? description,  DateTime? publishedAt,  String? urlToImage,  String? url,  String? source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  String? description,  DateTime? publishedAt,  String? urlToImage,  String? url,  String? source)  $default,) {final _that = this;
switch (_that) {
case _ArticleModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  String? description,  DateTime? publishedAt,  String? urlToImage,  String? url,  String? source)?  $default,) {final _that = this;
switch (_that) {
case _ArticleModel() when $default != null:
return $default(_that.title,_that.description,_that.publishedAt,_that.urlToImage,_that.url,_that.source);case _:
  return null;

}
}

}

/// @nodoc


class _ArticleModel implements ArticleModel {
  const _ArticleModel({this.title, this.description, this.publishedAt, this.urlToImage, this.url, this.source});
  

@override final  String? title;
@override final  String? description;
@override final  DateTime? publishedAt;
@override final  String? urlToImage;
@override final  String? url;
@override final  String? source;

/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleModelCopyWith<_ArticleModel> get copyWith => __$ArticleModelCopyWithImpl<_ArticleModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleModel&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.urlToImage, urlToImage) || other.urlToImage == urlToImage)&&(identical(other.url, url) || other.url == url)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode {
    return Object.hash(runtimeType,title,description,publishedAt,urlToImage,url,source);
}

@override
String toString() {
    return 'ArticleModel(title: $title, description: $description, publishedAt: $publishedAt, urlToImage: $urlToImage, url: $url, source: $source)';
}


}

/// @nodoc
abstract mixin class _$ArticleModelCopyWith<$Res> implements $ArticleModelCopyWith<$Res> {
  factory _$ArticleModelCopyWith(_ArticleModel value, $Res Function(_ArticleModel) _then) = __$ArticleModelCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? description, DateTime? publishedAt, String? urlToImage, String? url, String? source
});




}
/// @nodoc
class __$ArticleModelCopyWithImpl<$Res>
    implements _$ArticleModelCopyWith<$Res> {
  __$ArticleModelCopyWithImpl(this._self, this._then);

  final _ArticleModel _self;
  final $Res Function(_ArticleModel) _then;

/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? description = freezed,Object? publishedAt = freezed,Object? urlToImage = freezed,Object? url = freezed,Object? source = freezed,}) {
  return _then(_ArticleModel(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,urlToImage: freezed == urlToImage ? _self.urlToImage : urlToImage // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
