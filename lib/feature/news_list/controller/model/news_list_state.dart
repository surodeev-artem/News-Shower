import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_shower/feature/news_list/controller/model/article.dart';
import 'package:news_shower/feature/news_list/controller/model/news_list_error.dart';
import 'package:news_shower/feature/news_list/controller/model/news_list_item.dart';

part 'news_list_state.freezed.dart';

@freezed
sealed class NewsListState with _$NewsListState {
  const factory NewsListState.init() = NewsListStateInit;
  const factory NewsListState.loading() = NewsListStateLoading;
  const factory NewsListState.empty() = NewsListStateEmpty;
  const factory NewsListState.failure({required NewsListError error}) =
      NewsListStateFailure;
  const factory NewsListState.data({
    required List<Article> articles,
    required List<NewsListItem> items,
    @Default(1) int page,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasReachedEnd,
    NewsListError? loadMoreError,
  }) = NewsListStateData;
}
