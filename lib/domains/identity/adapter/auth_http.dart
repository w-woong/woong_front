import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woong_front/constants/constants.dart';
import 'package:woong_front/domains/identity/token.dart';
import 'package:woong_front/domains/identity/token_port.dart';

class AuthHttp implements AuthService {
  Dio client;
  String tokenSource;
  AuthHttp(this.client, this.tokenSource);

  @override
  Future<void> launchAuth(String authRequestID) async {
    var baseUrl = client.options.baseUrl;
    var path = AppConstant.authPath;
    var url = '$baseUrl$path/$tokenSource';

    bool res = await launchUrl(Uri.parse('$url/$authRequestID'),
        mode: LaunchMode.externalApplication);

    if (!res) {
      throw 'error launching $url';
    }
  }

  @override
  Future<void> launchAuthorization() async {
    var baseUrl = client.options.baseUrl;
    var path = AppConstant.authPath;
    var url = '$baseUrl$path/$tokenSource';

    bool res =
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

    if (!res) {
      throw 'error launching $url';
    }
  }

  @override
  Future<String> retrieveAuthRequestID() async {
    try {
      var path = AppConstant.authRetrievePath;
      var response = await client.get(
        '$path/$tokenSource',
        options: Options(
          headers: {
            Headers.contentTypeHeader: 'application/json',
          },
        ),
      );

      var decoded = jsonDecode(response.data) as Map<String, dynamic>;
      var status = decoded['status'] ?? 404;
      var message = decoded['message'] ?? 'unknown error';
      if (status != 200) {
        throw '$message(status:$status)';
      }
      if (decoded['document'] == null) {
        throw 'document is empty';
      }
      return decoded['document']['id'] ?? '';
    } on DioError catch (e) {
      if (e.response != null) {
        var decoded = jsonDecode(e.response?.data) as Map<String, dynamic>;
        var status = decoded['status'] ?? 404;
        var message = decoded['message'] ?? 'unknown error';
        throw '$message(status:$status)';
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Token> waitForToken(String authRequestID) async {
    try {
      var path = AppConstant.authWaitPath;
      var response = await client.get(
        '$path/$tokenSource/$authRequestID',
        options: Options(
          headers: {
            Headers.contentTypeHeader: 'application/json',
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
    } catch (e) {
      rethrow;
    }
  }
}
