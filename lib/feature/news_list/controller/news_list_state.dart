import 'package:news_shower/feature/news_list/controller/news_list.dart';
import 'package:news_shower/feature/news_list/controller/news_list_error.dart';

sealed class NewsListState {
  const NewsListState();

  factory NewsListState.loading() => NewsListStateLoading();
  factory NewsListState.empty() => NewsListStateEmpty();
  factory NewsListState.success(NewsList data) => NewsListStateSuccess(data);
  factory NewsListState.failure(NewsListError error) =>
      NewsListStateFailure(error);
}

final class NewsListStateLoading extends NewsListState;

final class NewsListStateEmpty extends NewsListState;

final class NewsListStateSuccess extends NewsListState {
  final NewsList data;

  const NewsListStateSuccess(this.data);
}

final class NewsListStateFailure extends NewsListState {
  final NewsListError error;

  const NewsListStateFailure(this.error);
}
