// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NewsSearchState {

 String get query; bool get isSearchButtonEnabled; NewsListState get listState;
/// Create a copy of NewsSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsSearchStateCopyWith<NewsSearchState> get copyWith => _$NewsSearchStateCopyWithImpl<NewsSearchState>(this as NewsSearchState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NewsSearchState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsSearchState&&(identical(other.query, _this.query) || other.query == _this.query)&&(identical(other.isSearchButtonEnabled, _this.isSearchButtonEnabled) || other.isSearchButtonEnabled == _this.isSearchButtonEnabled)&&(identical(other.listState, _this.listState) || other.listState == _this.listState));
}


@override
int get hashCode {
  final _this = this as NewsSearchState;
  return Object.hash(runtimeType,_this.query,_this.isSearchButtonEnabled,_this.listState);
}

@override
String toString() {
  final _this = this as NewsSearchState;
  return 'NewsSearchState(query: ${_this.query}, isSearchButtonEnabled: ${_this.isSearchButtonEnabled}, listState: ${_this.listState})';
}


}

/// @nodoc
abstract mixin class $NewsSearchStateCopyWith<$Res>  {
  factory $NewsSearchStateCopyWith(NewsSearchState value, $Res Function(NewsSearchState) _then) = _$NewsSearchStateCopyWithImpl;
@useResult
$Res call({
 String query, bool isSearchButtonEnabled, NewsListState listState
});


$NewsListStateCopyWith<$Res> get listState;

}
/// @nodoc
class _$NewsSearchStateCopyWithImpl<$Res>
    implements $NewsSearchStateCopyWith<$Res> {
  _$NewsSearchStateCopyWithImpl(this._self, this._then);

  final NewsSearchState _self;
  final $Res Function(NewsSearchState) _then;

/// Create a copy of NewsSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? isSearchButtonEnabled = null,Object? listState = null,}) {
  return _then(NewsSearchState(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,isSearchButtonEnabled: null == isSearchButtonEnabled ? _self.isSearchButtonEnabled : isSearchButtonEnabled // ignore: cast_nullable_to_non_nullable
as bool,listState: null == listState ? _self.listState : listState // ignore: cast_nullable_to_non_nullable
as NewsListState,
  ));
}
/// Create a copy of NewsSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NewsListStateCopyWith<$Res> get listState {
  
  return $NewsListStateCopyWith<$Res>(_self.listState, (value) {
    return _then(_self.copyWith(listState: value));
  });
}
}


/// Adds pattern-matching-related methods to [NewsSearchState].
extension NewsSearchStatePatterns on NewsSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewsSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewsSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewsSearchState value)  $default,){
final _that = this;
switch (_that) {
case _NewsSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewsSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _NewsSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  bool isSearchButtonEnabled,  NewsListState listState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewsSearchState() when $default != null:
return $default(_that.query,_that.isSearchButtonEnabled,_that.listState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  bool isSearchButtonEnabled,  NewsListState listState)  $default,) {final _that = this;
switch (_that) {
case _NewsSearchState():
return $default(_that.query,_that.isSearchButtonEnabled,_that.listState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  bool isSearchButtonEnabled,  NewsListState listState)?  $default,) {final _that = this;
switch (_that) {
case _NewsSearchState() when $default != null:
return $default(_that.query,_that.isSearchButtonEnabled,_that.listState);case _:
  return null;

}
}

}

/// @nodoc


class _NewsSearchState implements NewsSearchState {
  const _NewsSearchState({required this.query, required this.isSearchButtonEnabled, required this.listState});
  

@override final  String query;
@override final  bool isSearchButtonEnabled;
@override final  NewsListState listState;

/// Create a copy of NewsSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsSearchStateCopyWith<_NewsSearchState> get copyWith => __$NewsSearchStateCopyWithImpl<_NewsSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsSearchState&&(identical(other.query, query) || other.query == query)&&(identical(other.isSearchButtonEnabled, isSearchButtonEnabled) || other.isSearchButtonEnabled == isSearchButtonEnabled)&&(identical(other.listState, listState) || other.listState == listState));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query,isSearchButtonEnabled,listState);
}

@override
String toString() {
    return 'NewsSearchState(query: $query, isSearchButtonEnabled: $isSearchButtonEnabled, listState: $listState)';
}


}

/// @nodoc
abstract mixin class _$NewsSearchStateCopyWith<$Res> implements $NewsSearchStateCopyWith<$Res> {
  factory _$NewsSearchStateCopyWith(_NewsSearchState value, $Res Function(_NewsSearchState) _then) = __$NewsSearchStateCopyWithImpl;
@override @useResult
$Res call({
 String query, bool isSearchButtonEnabled, NewsListState listState
});


@override $NewsListStateCopyWith<$Res> get listState;

}
/// @nodoc
class __$NewsSearchStateCopyWithImpl<$Res>
    implements _$NewsSearchStateCopyWith<$Res> {
  __$NewsSearchStateCopyWithImpl(this._self, this._then);

  final _NewsSearchState _self;
  final $Res Function(_NewsSearchState) _then;

/// Create a copy of NewsSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? isSearchButtonEnabled = null,Object? listState = null,}) {
  return _then(_NewsSearchState(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,isSearchButtonEnabled: null == isSearchButtonEnabled ? _self.isSearchButtonEnabled : isSearchButtonEnabled // ignore: cast_nullable_to_non_nullable
as bool,listState: null == listState ? _self.listState : listState // ignore: cast_nullable_to_non_nullable
as NewsListState,
  ));
}

/// Create a copy of NewsSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NewsListStateCopyWith<$Res> get listState {
  
  return $NewsListStateCopyWith<$Res>(_self.listState, (value) {
    return _then(_self.copyWith(listState: value));
  });
}
}

// dart format on
