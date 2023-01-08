class UnauthorizedException implements Exception {
  final String cause;
  UnauthorizedException(this.cause);
}
