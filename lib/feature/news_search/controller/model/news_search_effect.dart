import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_search_effect.freezed.dart';

@freezed
sealed class NewsSearchEffect with _$NewsSearchEffect {
  const factory NewsSearchEffect.articleUrlIsNotValid() =
      NewsSearchEffectArticleUrlIsNotValid;
}
