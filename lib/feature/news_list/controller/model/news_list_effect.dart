import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_list_effect.freezed.dart';

@freezed
sealed class NewsListEffect with _$NewsListEffect {
  const factory NewsListEffect.articleUrlIsNotValid() =
      NewsListEffectArticleUrlIsNotValid;
}
