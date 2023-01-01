class TokenExpiredException implements Exception {
  final String cause;
  TokenExpiredException(this.cause);
}

class UnauthorizedException implements Exception {
  final String cause;
  UnauthorizedException(this.cause);
}
