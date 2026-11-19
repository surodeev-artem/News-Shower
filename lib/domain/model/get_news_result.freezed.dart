// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_news_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetNewsResult {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is GetNewsResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'GetNewsResult()';
}


}

/// @nodoc
class $GetNewsResultCopyWith<$Res>  {
$GetNewsResultCopyWith(GetNewsResult _, $Res Function(GetNewsResult) __);
}


/// Adds pattern-matching-related methods to [GetNewsResult].
extension GetNewsResultPatterns on GetNewsResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GetNewsResultSuccess value)?  success,TResult Function( GetNewsResultFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GetNewsResultSuccess() when success != null:
return success(_that);case GetNewsResultFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GetNewsResultSuccess value)  success,required TResult Function( GetNewsResultFailure value)  failure,}){
final _that = this;
switch (_that) {
case GetNewsResultSuccess():
return success(_that);case GetNewsResultFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GetNewsResultSuccess value)?  success,TResult? Function( GetNewsResultFailure value)?  failure,}){
final _that = this;
switch (_that) {
case GetNewsResultSuccess() when success != null:
return success(_that);case GetNewsResultFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<ArticleModel> articles)?  success,TResult Function( GetNewsError error)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GetNewsResultSuccess() when success != null:
return success(_that.articles);case GetNewsResultFailure() when failure != null:
return failure(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<ArticleModel> articles)  success,required TResult Function( GetNewsError error)  failure,}) {final _that = this;
switch (_that) {
case GetNewsResultSuccess():
return success(_that.articles);case GetNewsResultFailure():
return failure(_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<ArticleModel> articles)?  success,TResult? Function( GetNewsError error)?  failure,}) {final _that = this;
switch (_that) {
case GetNewsResultSuccess() when success != null:
return success(_that.articles);case GetNewsResultFailure() when failure != null:
return failure(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class GetNewsResultSuccess implements GetNewsResult {
  const GetNewsResultSuccess({required  List<ArticleModel> articles}): _articles = articles;
  

 final  List<ArticleModel> _articles;
 List<ArticleModel> get articles {
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articles);
}


/// Create a copy of GetNewsResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetNewsResultSuccessCopyWith<GetNewsResultSuccess> get copyWith => _$GetNewsResultSuccessCopyWithImpl<GetNewsResultSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is GetNewsResultSuccess&&const DeepCollectionEquality().equals(other.articles, _articles));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_articles));
}

@override
String toString() {
    return 'GetNewsResult.success(articles: $articles)';
}


}

/// @nodoc
abstract mixin class $GetNewsResultSuccessCopyWith<$Res> implements $GetNewsResultCopyWith<$Res> {
  factory $GetNewsResultSuccessCopyWith(GetNewsResultSuccess value, $Res Function(GetNewsResultSuccess) _then) = _$GetNewsResultSuccessCopyWithImpl;
@useResult
$Res call({
 List<ArticleModel> articles
});




}
/// @nodoc
class _$GetNewsResultSuccessCopyWithImpl<$Res>
    implements $GetNewsResultSuccessCopyWith<$Res> {
  _$GetNewsResultSuccessCopyWithImpl(this._self, this._then);

  final GetNewsResultSuccess _self;
  final $Res Function(GetNewsResultSuccess) _then;

/// Create a copy of GetNewsResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? articles = null,}) {
  return _then(GetNewsResultSuccess(
articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<ArticleModel>,
  ));
}


}

/// @nodoc


class GetNewsResultFailure implements GetNewsResult {
  const GetNewsResultFailure({required this.error});
  

 final  GetNewsError error;

/// Create a copy of GetNewsResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetNewsResultFailureCopyWith<GetNewsResultFailure> get copyWith => _$GetNewsResultFailureCopyWithImpl<GetNewsResultFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is GetNewsResultFailure&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,error);
}

@override
String toString() {
    return 'GetNewsResult.failure(error: $error)';
}


}

/// @nodoc
abstract mixin class $GetNewsResultFailureCopyWith<$Res> implements $GetNewsResultCopyWith<$Res> {
  factory $GetNewsResultFailureCopyWith(GetNewsResultFailure value, $Res Function(GetNewsResultFailure) _then) = _$GetNewsResultFailureCopyWithImpl;
@useResult
$Res call({
 GetNewsError error
});


$GetNewsErrorCopyWith<$Res> get error;

}
/// @nodoc
class _$GetNewsResultFailureCopyWithImpl<$Res>
    implements $GetNewsResultFailureCopyWith<$Res> {
  _$GetNewsResultFailureCopyWithImpl(this._self, this._then);

  final GetNewsResultFailure _self;
  final $Res Function(GetNewsResultFailure) _then;

/// Create a copy of GetNewsResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(GetNewsResultFailure(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as GetNewsError,
  ));
}

/// Create a copy of GetNewsResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GetNewsErrorCopyWith<$Res> get error {
  
  return $GetNewsErrorCopyWith<$Res>(_self.error, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}

// dart format on
