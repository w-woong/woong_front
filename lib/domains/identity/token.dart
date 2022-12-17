import 'dart:convert';

class Token {
  String tid;
  String idToken;
  int expiry;
  String tokenSource;

  Token(
      {required this.tid,
      required this.idToken,
      required this.expiry,
      required this.tokenSource});
  Token.empty()
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

  Token.fromJson(Map<String, dynamic> json)
      : tid = json['tid'] ?? '',
        idToken = json['id_token'] ?? '',
        tokenSource = json['token_source'] ?? '',
        expiry = json['expiry'] ?? 0;

  Map<String, dynamic> toJson() {
    return {
      'tid': tid,
      'id_token': idToken,
      'expiry': expiry,
      'token_source': tokenSource,
    };
  }

  String toJsonString() {
    return json.encode(toJson());
  }
}
