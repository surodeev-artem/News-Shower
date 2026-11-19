// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NewsListState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NewsListState()';
}


}

/// @nodoc
class $NewsListStateCopyWith<$Res>  {
$NewsListStateCopyWith(NewsListState _, $Res Function(NewsListState) __);
}


/// Adds pattern-matching-related methods to [NewsListState].
extension NewsListStatePatterns on NewsListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NewsListStateInit value)?  init,TResult Function( NewsListStateLoading value)?  loading,TResult Function( NewsListStateEmpty value)?  empty,TResult Function( NewsListStateFailure value)?  failure,TResult Function( NewsListStateData value)?  data,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NewsListStateInit() when init != null:
return init(_that);case NewsListStateLoading() when loading != null:
return loading(_that);case NewsListStateEmpty() when empty != null:
return empty(_that);case NewsListStateFailure() when failure != null:
return failure(_that);case NewsListStateData() when data != null:
return data(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NewsListStateInit value)  init,required TResult Function( NewsListStateLoading value)  loading,required TResult Function( NewsListStateEmpty value)  empty,required TResult Function( NewsListStateFailure value)  failure,required TResult Function( NewsListStateData value)  data,}){
final _that = this;
switch (_that) {
case NewsListStateInit():
return init(_that);case NewsListStateLoading():
return loading(_that);case NewsListStateEmpty():
return empty(_that);case NewsListStateFailure():
return failure(_that);case NewsListStateData():
return data(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NewsListStateInit value)?  init,TResult? Function( NewsListStateLoading value)?  loading,TResult? Function( NewsListStateEmpty value)?  empty,TResult? Function( NewsListStateFailure value)?  failure,TResult? Function( NewsListStateData value)?  data,}){
final _that = this;
switch (_that) {
case NewsListStateInit() when init != null:
return init(_that);case NewsListStateLoading() when loading != null:
return loading(_that);case NewsListStateEmpty() when empty != null:
return empty(_that);case NewsListStateFailure() when failure != null:
return failure(_that);case NewsListStateData() when data != null:
return data(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  init,TResult Function()?  loading,TResult Function()?  empty,TResult Function( NewsListError error)?  failure,TResult Function( List<Article> articles,  int page,  bool isLoadingMore,  bool hasReachedEnd,  NewsListError? loadMoreError)?  data,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NewsListStateInit() when init != null:
return init();case NewsListStateLoading() when loading != null:
return loading();case NewsListStateEmpty() when empty != null:
return empty();case NewsListStateFailure() when failure != null:
return failure(_that.error);case NewsListStateData() when data != null:
return data(_that.articles,_that.page,_that.isLoadingMore,_that.hasReachedEnd,_that.loadMoreError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  init,required TResult Function()  loading,required TResult Function()  empty,required TResult Function( NewsListError error)  failure,required TResult Function( List<Article> articles,  int page,  bool isLoadingMore,  bool hasReachedEnd,  NewsListError? loadMoreError)  data,}) {final _that = this;
switch (_that) {
case NewsListStateInit():
return init();case NewsListStateLoading():
return loading();case NewsListStateEmpty():
return empty();case NewsListStateFailure():
return failure(_that.error);case NewsListStateData():
return data(_that.articles,_that.page,_that.isLoadingMore,_that.hasReachedEnd,_that.loadMoreError);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  init,TResult? Function()?  loading,TResult? Function()?  empty,TResult? Function( NewsListError error)?  failure,TResult? Function( List<Article> articles,  int page,  bool isLoadingMore,  bool hasReachedEnd,  NewsListError? loadMoreError)?  data,}) {final _that = this;
switch (_that) {
case NewsListStateInit() when init != null:
return init();case NewsListStateLoading() when loading != null:
return loading();case NewsListStateEmpty() when empty != null:
return empty();case NewsListStateFailure() when failure != null:
return failure(_that.error);case NewsListStateData() when data != null:
return data(_that.articles,_that.page,_that.isLoadingMore,_that.hasReachedEnd,_that.loadMoreError);case _:
  return null;

}
}

}

/// @nodoc


class NewsListStateInit implements NewsListState {
  const NewsListStateInit();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsListStateInit);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NewsListState.init()';
}


}




/// @nodoc


class NewsListStateLoading implements NewsListState {
  const NewsListStateLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsListStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NewsListState.loading()';
}


}




/// @nodoc


class NewsListStateEmpty implements NewsListState {
  const NewsListStateEmpty();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsListStateEmpty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NewsListState.empty()';
}


}




/// @nodoc


class NewsListStateFailure implements NewsListState {
  const NewsListStateFailure({required this.error});
  

 final  NewsListError error;

/// Create a copy of NewsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsListStateFailureCopyWith<NewsListStateFailure> get copyWith => _$NewsListStateFailureCopyWithImpl<NewsListStateFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsListStateFailure&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,error);
}

@override
String toString() {
    return 'NewsListState.failure(error: $error)';
}


}

/// @nodoc
abstract mixin class $NewsListStateFailureCopyWith<$Res> implements $NewsListStateCopyWith<$Res> {
  factory $NewsListStateFailureCopyWith(NewsListStateFailure value, $Res Function(NewsListStateFailure) _then) = _$NewsListStateFailureCopyWithImpl;
@useResult
$Res call({
 NewsListError error
});


$NewsListErrorCopyWith<$Res> get error;

}
/// @nodoc
class _$NewsListStateFailureCopyWithImpl<$Res>
    implements $NewsListStateFailureCopyWith<$Res> {
  _$NewsListStateFailureCopyWithImpl(this._self, this._then);

  final NewsListStateFailure _self;
  final $Res Function(NewsListStateFailure) _then;

/// Create a copy of NewsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(NewsListStateFailure(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as NewsListError,
  ));
}

/// Create a copy of NewsListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NewsListErrorCopyWith<$Res> get error {
  
  return $NewsListErrorCopyWith<$Res>(_self.error, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}

/// @nodoc


class NewsListStateData implements NewsListState {
  const NewsListStateData({required  List<Article> articles, this.page = 1, this.isLoadingMore = false, this.hasReachedEnd = false, this.loadMoreError}): _articles = articles;
  

 final  List<Article> _articles;
 List<Article> get articles {
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articles);
}

@JsonKey() final  int page;
@JsonKey() final  bool isLoadingMore;
@JsonKey() final  bool hasReachedEnd;
 final  NewsListError? loadMoreError;

/// Create a copy of NewsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsListStateDataCopyWith<NewsListStateData> get copyWith => _$NewsListStateDataCopyWithImpl<NewsListStateData>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsListStateData&&const DeepCollectionEquality().equals(other.articles, _articles)&&(identical(other.page, page) || other.page == page)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd)&&(identical(other.loadMoreError, loadMoreError) || other.loadMoreError == loadMoreError));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_articles),page,isLoadingMore,hasReachedEnd,loadMoreError);
}

@override
String toString() {
    return 'NewsListState.data(articles: $articles, page: $page, isLoadingMore: $isLoadingMore, hasReachedEnd: $hasReachedEnd, loadMoreError: $loadMoreError)';
}


}

/// @nodoc
abstract mixin class $NewsListStateDataCopyWith<$Res> implements $NewsListStateCopyWith<$Res> {
  factory $NewsListStateDataCopyWith(NewsListStateData value, $Res Function(NewsListStateData) _then) = _$NewsListStateDataCopyWithImpl;
@useResult
$Res call({
 List<Article> articles, int page, bool isLoadingMore, bool hasReachedEnd, NewsListError? loadMoreError
});


$NewsListErrorCopyWith<$Res>? get loadMoreError;

}
/// @nodoc
class _$NewsListStateDataCopyWithImpl<$Res>
    implements $NewsListStateDataCopyWith<$Res> {
  _$NewsListStateDataCopyWithImpl(this._self, this._then);

  final NewsListStateData _self;
  final $Res Function(NewsListStateData) _then;

/// Create a copy of NewsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? articles = null,Object? page = null,Object? isLoadingMore = null,Object? hasReachedEnd = null,Object? loadMoreError = freezed,}) {
  return _then(NewsListStateData(
articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<Article>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,loadMoreError: freezed == loadMoreError ? _self.loadMoreError : loadMoreError // ignore: cast_nullable_to_non_nullable
as NewsListError?,
  ));
}

/// Create a copy of NewsListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NewsListErrorCopyWith<$Res>? get loadMoreError {
    if (_self.loadMoreError == null) {
    return null;
  }

  return $NewsListErrorCopyWith<$Res>(_self.loadMoreError!, (value) {
    return _then(_self.copyWith(loadMoreError: value));
  });
}
}

// dart format on
