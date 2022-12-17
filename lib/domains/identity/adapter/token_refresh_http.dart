import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:woong_front/constants/constants.dart';
import 'package:woong_front/domains/identity/token.dart';
import 'package:woong_front/domains/identity/token_port.dart';

class TokenRefreshHttp implements TokenRefreshService {
  Dio client;
  TokenRefreshHttp(this.client);

  @override
  Future<Token> refresh(Token token) async {
    try {
      var response = await client.get(
        '$AppConstant.authRefreshPath/$token.tokenSource',
        options: Options(
          headers: {
            Headers.contentTypeHeader: 'application/json',
            'tid': token.tid,
            'id_token': token.idToken,
            'token_source': token.tokenSource,
          },
        ),
      );

      var decoded = jsonDecode(response.data) as Map<String, dynamic>;
      // var status = decoded['status'] ?? 404;
      // var message = decoded['message'] ?? 'unknown error';
      // if (status != 200) {
      //   throw '$message(status:$status)';
      // }

      var idToken = decoded['id_token'] as String;
      var tid = decoded['tid'] as String;
      var expiry = decoded['expiry'] as int;
      var aTokenSource = decoded['token_source'] as String;
      return Token(
          tid: tid,
          idToken: idToken,
          expiry: expiry,
          tokenSource: aTokenSource);
      // return Token.fromJson(decoded['document']);
    } catch (e) {
      rethrow;
    }
  }
}
