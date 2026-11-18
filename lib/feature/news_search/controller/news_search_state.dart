import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_search_state.freezed.dart';

@freezed
abstract class NewsSearchState with _$NewsSearchState {
  const factory NewsSearchState({required bool isSearchButtonEnabled}) =
      _NewsSearchState;
}
