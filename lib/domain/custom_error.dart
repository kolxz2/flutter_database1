class EmptySearchError implements Exception {
  String cause;
  EmptySearchError(this.cause);
}
