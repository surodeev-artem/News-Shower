// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_search_effect.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NewsSearchEffect {

 String get query;
/// Create a copy of NewsSearchEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsSearchEffectCopyWith<NewsSearchEffect> get copyWith => _$NewsSearchEffectCopyWithImpl<NewsSearchEffect>(this as NewsSearchEffect, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NewsSearchEffect;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsSearchEffect&&(identical(other.query, _this.query) || other.query == _this.query));
}


@override
int get hashCode {
  final _this = this as NewsSearchEffect;
  return Object.hash(runtimeType,_this.query);
}

@override
String toString() {
  final _this = this as NewsSearchEffect;
  return 'NewsSearchEffect(query: ${_this.query})';
}


}

/// @nodoc
abstract mixin class $NewsSearchEffectCopyWith<$Res>  {
  factory $NewsSearchEffectCopyWith(NewsSearchEffect value, $Res Function(NewsSearchEffect) _then) = _$NewsSearchEffectCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$NewsSearchEffectCopyWithImpl<$Res>
    implements $NewsSearchEffectCopyWith<$Res> {
  _$NewsSearchEffectCopyWithImpl(this._self, this._then);

  final NewsSearchEffect _self;
  final $Res Function(NewsSearchEffect) _then;

/// Create a copy of NewsSearchEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,}) {
  return _then(NewsSearchEffect.goToList(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NewsSearchEffect].
extension NewsSearchEffectPatterns on NewsSearchEffect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NewsSearchEffectGoToList value)?  goToList,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NewsSearchEffectGoToList() when goToList != null:
return goToList(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NewsSearchEffectGoToList value)  goToList,}){
final _that = this;
switch (_that) {
case NewsSearchEffectGoToList():
return goToList(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NewsSearchEffectGoToList value)?  goToList,}){
final _that = this;
switch (_that) {
case NewsSearchEffectGoToList() when goToList != null:
return goToList(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String query)?  goToList,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NewsSearchEffectGoToList() when goToList != null:
return goToList(_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String query)  goToList,}) {final _that = this;
switch (_that) {
case NewsSearchEffectGoToList():
return goToList(_that.query);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String query)?  goToList,}) {final _that = this;
switch (_that) {
case NewsSearchEffectGoToList() when goToList != null:
return goToList(_that.query);case _:
  return null;

}
}

}

/// @nodoc


class NewsSearchEffectGoToList implements NewsSearchEffect {
  const NewsSearchEffectGoToList({required this.query});
  

@override final  String query;

/// Create a copy of NewsSearchEffect
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsSearchEffectGoToListCopyWith<NewsSearchEffectGoToList> get copyWith => _$NewsSearchEffectGoToListCopyWithImpl<NewsSearchEffectGoToList>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsSearchEffectGoToList&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query);
}

@override
String toString() {
    return 'NewsSearchEffect.goToList(query: $query)';
}


}

/// @nodoc
abstract mixin class $NewsSearchEffectGoToListCopyWith<$Res> implements $NewsSearchEffectCopyWith<$Res> {
  factory $NewsSearchEffectGoToListCopyWith(NewsSearchEffectGoToList value, $Res Function(NewsSearchEffectGoToList) _then) = _$NewsSearchEffectGoToListCopyWithImpl;
@override @useResult
$Res call({
 String query
});




}
/// @nodoc
class _$NewsSearchEffectGoToListCopyWithImpl<$Res>
    implements $NewsSearchEffectGoToListCopyWith<$Res> {
  _$NewsSearchEffectGoToListCopyWithImpl(this._self, this._then);

  final NewsSearchEffectGoToList _self;
  final $Res Function(NewsSearchEffectGoToList) _then;

/// Create a copy of NewsSearchEffect
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(NewsSearchEffectGoToList(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
