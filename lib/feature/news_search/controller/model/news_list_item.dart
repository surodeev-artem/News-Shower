import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_shower/feature/news_search/controller/model/article.dart';

part 'news_list_item.freezed.dart';

@freezed
sealed class NewsListItem with _$NewsListItem {
  const factory NewsListItem.date(DateTime date) = NewsListItemDate;
  const factory NewsListItem.unknownDate() = NewsListItemUnknownDate;
  const factory NewsListItem.article(Article article) = NewsListItemArticle;
}
