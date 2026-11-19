import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_shower/domain/model/article_model.dart';
import 'package:news_shower/domain/model/get_news_error.dart';

part 'get_news_result.freezed.dart';

@freezed
sealed class GetNewsResult with _$GetNewsResult {
  const factory GetNewsResult.success({required List<ArticleModel> articles}) =
      GetNewsResultSuccess;

  const factory GetNewsResult.failure({required GetNewsError error}) =
      GetNewsResultFailure;
}
