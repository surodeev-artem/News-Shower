abstract class NewsApi {
  Stream<Map<String, dynamic>> getNewsByQuery(
    String query,
    int pageIndex,
    int pageSize,
  );
}
