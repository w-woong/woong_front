import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:woong_front/domains/identity/token.dart';

abstract class TokenRepo {
  Future<void> create(Token identity);
  Future<Token> read();
  Future<void> delete();
}

class TokenSecureStorage implements TokenRepo {
  FlutterSecureStorage storage;
  TokenSecureStorage(this.storage);

  @override
  Future<void> create(Token identity) async {
    await storage.write(key: 'token', value: identity.toJsonString());
    // await storage.write(key: 'tid', value: identity.tid);
    // await storage.write(key: 'id_token', value: identity.idToken);
    // await storage.write(key: 'token_source', value: identity.tokenSource);
    // await storage.write(key: 'expiry', value: identity.expiry as String);
  }

  @override
  Future<Token> read() async {
    try {
      String token = await storage.read(key: 'token') as String;
      var map = json.decode(token);
      return Token.fromJson(map);
    } catch (e) {
      return Token.empty();
    }
    // String tid = await storage.read(key: 'tid') as String;
    // String idToken = await storage.read(key: 'id_token') as String;
    // String tokenSource = await storage.read(key: 'token_source') as String;

    // return Identity(
    //     tid: tid, idToken: idToken, tokenSource: tokenSource, expiry: 0);
  }

  @override
  Future<void> delete() async {
    await storage.delete(key: 'token');
  }
}
