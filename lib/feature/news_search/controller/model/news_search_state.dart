import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_shower/feature/news_search/controller/model/news_list_state.dart';

part 'news_search_state.freezed.dart';

@freezed
abstract class NewsSearchState with _$NewsSearchState {
  const factory NewsSearchState({
    required String query,
    required bool isSearchButtonEnabled,
    required NewsListState listState,
  }) = _NewsSearchState;
}
