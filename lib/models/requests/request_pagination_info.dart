class RequestPaginationInfo{
  final int page;
  final int perPage;

  const RequestPaginationInfo({
    required this.page,
    required this.perPage
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'per_page': perPage,
    };
  }
}