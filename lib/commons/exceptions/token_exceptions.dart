class TokenExpiredException implements Exception {
  final String cause;
  TokenExpiredException(this.cause);
}
