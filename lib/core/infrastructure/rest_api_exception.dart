class RestApiException implements Exception {
  final int? errorCoed;

  RestApiException(this.errorCoed);
}
