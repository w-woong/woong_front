class Identity {
  String tid;
  String idToken;
  int expiry;
  String tokenSource;

  Identity(
      {required this.tid,
      required this.idToken,
      required this.expiry,
      required this.tokenSource});
  Identity.empty()
      : tid = '',
        idToken = '',
        expiry = 0,
        tokenSource = '';

  bool isEmpty() {
    if (tid == '' || idToken == '') {
      return true;
    }

    return false;
  }
}

class TokenExpiredException implements Exception {
  final String cause;
  TokenExpiredException(this.cause);
}
