// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_list_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NewsListItem {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsListItem);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NewsListItem()';
}


}

/// @nodoc
class $NewsListItemCopyWith<$Res>  {
$NewsListItemCopyWith(NewsListItem _, $Res Function(NewsListItem) __);
}


/// Adds pattern-matching-related methods to [NewsListItem].
extension NewsListItemPatterns on NewsListItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NewsListItemDate value)?  date,TResult Function( NewsListItemUnknownDate value)?  unknownDate,TResult Function( NewsListItemArticle value)?  article,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NewsListItemDate() when date != null:
return date(_that);case NewsListItemUnknownDate() when unknownDate != null:
return unknownDate(_that);case NewsListItemArticle() when article != null:
return article(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NewsListItemDate value)  date,required TResult Function( NewsListItemUnknownDate value)  unknownDate,required TResult Function( NewsListItemArticle value)  article,}){
final _that = this;
switch (_that) {
case NewsListItemDate():
return date(_that);case NewsListItemUnknownDate():
return unknownDate(_that);case NewsListItemArticle():
return article(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NewsListItemDate value)?  date,TResult? Function( NewsListItemUnknownDate value)?  unknownDate,TResult? Function( NewsListItemArticle value)?  article,}){
final _that = this;
switch (_that) {
case NewsListItemDate() when date != null:
return date(_that);case NewsListItemUnknownDate() when unknownDate != null:
return unknownDate(_that);case NewsListItemArticle() when article != null:
return article(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( DateTime date)?  date,TResult Function()?  unknownDate,TResult Function( Article article)?  article,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NewsListItemDate() when date != null:
return date(_that.date);case NewsListItemUnknownDate() when unknownDate != null:
return unknownDate();case NewsListItemArticle() when article != null:
return article(_that.article);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( DateTime date)  date,required TResult Function()  unknownDate,required TResult Function( Article article)  article,}) {final _that = this;
switch (_that) {
case NewsListItemDate():
return date(_that.date);case NewsListItemUnknownDate():
return unknownDate();case NewsListItemArticle():
return article(_that.article);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( DateTime date)?  date,TResult? Function()?  unknownDate,TResult? Function( Article article)?  article,}) {final _that = this;
switch (_that) {
case NewsListItemDate() when date != null:
return date(_that.date);case NewsListItemUnknownDate() when unknownDate != null:
return unknownDate();case NewsListItemArticle() when article != null:
return article(_that.article);case _:
  return null;

}
}

}

/// @nodoc


class NewsListItemDate implements NewsListItem {
  const NewsListItemDate(this.date);
  

 final  DateTime date;

/// Create a copy of NewsListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsListItemDateCopyWith<NewsListItemDate> get copyWith => _$NewsListItemDateCopyWithImpl<NewsListItemDate>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsListItemDate&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode {
    return Object.hash(runtimeType,date);
}

@override
String toString() {
    return 'NewsListItem.date(date: $date)';
}


}

/// @nodoc
abstract mixin class $NewsListItemDateCopyWith<$Res> implements $NewsListItemCopyWith<$Res> {
  factory $NewsListItemDateCopyWith(NewsListItemDate value, $Res Function(NewsListItemDate) _then) = _$NewsListItemDateCopyWithImpl;
@useResult
$Res call({
 DateTime date
});




}
/// @nodoc
class _$NewsListItemDateCopyWithImpl<$Res>
    implements $NewsListItemDateCopyWith<$Res> {
  _$NewsListItemDateCopyWithImpl(this._self, this._then);

  final NewsListItemDate _self;
  final $Res Function(NewsListItemDate) _then;

/// Create a copy of NewsListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = null,}) {
  return _then(NewsListItemDate(
null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class NewsListItemUnknownDate implements NewsListItem {
  const NewsListItemUnknownDate();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsListItemUnknownDate);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NewsListItem.unknownDate()';
}


}




/// @nodoc


class NewsListItemArticle implements NewsListItem {
  const NewsListItemArticle(this.article);
  

 final  Article article;

/// Create a copy of NewsListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsListItemArticleCopyWith<NewsListItemArticle> get copyWith => _$NewsListItemArticleCopyWithImpl<NewsListItemArticle>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsListItemArticle&&(identical(other.article, article) || other.article == article));
}


@override
int get hashCode {
    return Object.hash(runtimeType,article);
}

@override
String toString() {
    return 'NewsListItem.article(article: $article)';
}


}

/// @nodoc
abstract mixin class $NewsListItemArticleCopyWith<$Res> implements $NewsListItemCopyWith<$Res> {
  factory $NewsListItemArticleCopyWith(NewsListItemArticle value, $Res Function(NewsListItemArticle) _then) = _$NewsListItemArticleCopyWithImpl;
@useResult
$Res call({
 Article article
});


$ArticleCopyWith<$Res> get article;

}
/// @nodoc
class _$NewsListItemArticleCopyWithImpl<$Res>
    implements $NewsListItemArticleCopyWith<$Res> {
  _$NewsListItemArticleCopyWithImpl(this._self, this._then);

  final NewsListItemArticle _self;
  final $Res Function(NewsListItemArticle) _then;

/// Create a copy of NewsListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? article = null,}) {
  return _then(NewsListItemArticle(
null == article ? _self.article : article // ignore: cast_nullable_to_non_nullable
as Article,
  ));
}

/// Create a copy of NewsListItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArticleCopyWith<$Res> get article {
  
  return $ArticleCopyWith<$Res>(_self.article, (value) {
    return _then(_self.copyWith(article: value));
  });
}
}

// dart format on
