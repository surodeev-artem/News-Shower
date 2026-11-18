sealed class NewsSearchEffect {
  const NewsSearchEffect();

  factory NewsSearchEffect.goToList({required String query}) =>
      NewsSearchEffectGoToList(query);
}

final class NewsSearchEffectGoToList extends NewsSearchEffect {
  final String query;

  const NewsSearchEffectGoToList(this.query);
}
