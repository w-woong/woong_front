import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:woong_front/constants/constants.dart';
import 'package:woong_front/domains/identity/identity.dart';

class LoginRepo {
  LoginRepo();

  // final String startUrl = 'https://localhost:5558/v1/auth/request';
  // final String waitUrl = 'https://localhost:5558/v1/auth/request';
  // final String authUrl = 'https://localhost:5558/v1/auth/authorize';
  // final String validateUrl = 'https://localhost:5558/v1/auth/validate';

  // Future<http.Response> _getAuthRequest() async {
  //   return await http.get(Uri.parse(startUrl));
  // }
  Future<String> _getAuthRequest() async {
    var url = AppConstant.authStartUrl.replaceAll('{token_source}', 'google');
    var response = await http.get(Uri.parse(url));

    if (response.statusCode >= 400 || response.statusCode < 100) {
      throw 'error ${response.statusCode}';
    }

    var decoded =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    int status = decoded['status'];
    if (decoded['status'] != 200) {
      throw 'error $status';
    }

    var authRequestID = decoded['document']['id'] as String;
    return authRequestID;
  }

  Future<Identity> _waitAuthorized(String authRequestID) async {
    var url = AppConstant.authWaitUrl.replaceAll('{token_source}', 'google');
    var response = await http.get(Uri.parse('$url/$authRequestID'));
    if (response.statusCode != 200) {
      throw 'Could not authorize';
    }

    var decoded = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    var idToken = decoded['id_token'] as String;
    var tid = decoded['tid'] as String;
    var expiry = decoded['expiry'] as int;
    var tokenSource = decoded['token_source'] as String;
    return Identity(
        tid: tid, idToken: idToken, expiry: expiry, tokenSource: tokenSource);
  }

  // Future<void> _authorize(String authRequestID) async {
  //   bool res = await launchUrl(Uri.parse('$authUrl/$authRequestID'),
  //       mode: LaunchMode.externalApplication);

  //   if (!res) {
  //     throw 'Could not launch';
  //   }
  // }

  Future<void> _authorize(String authRequestID) async {
    var url = AppConstant.authUrl.replaceAll('{token_source}', 'google');
    bool res = await launchUrl(Uri.parse('$url/$authRequestID'),
        mode: LaunchMode.externalApplication);

    if (!res) {
      throw 'Could not launch';
    }
  }

  Future<Identity> authorize() async {
    var authRequestID = await _getAuthRequest();
    print(authRequestID);

    _authorize(authRequestID);
    return await _waitAuthorized(authRequestID);
  }

  Future<Identity> validate(Identity identity) async {
    var url = AppConstant.authValidateUrl
        .replaceAll('{token_source}', identity.tokenSource);

    var response = await http.get(Uri.parse(url), headers: {
      "tid": identity.tid,
      "id_token": identity.idToken,
      "token_source": identity.tokenSource,
    });
    if (response.statusCode != 200) {
      throw 'Could not get auth request';
    }
    // var decoded = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    // var authRequestID = decoded['id'] as String;
    // return authRequestID;
    var decoded = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    var resIDToken = decoded['id_token'] as String;
    var resTID = decoded['tid'] as String;
    var resExpiry = decoded['expiry'] as int;
    var tokenSource = decoded['token_source'] as String;
    return Identity(
        tid: resTID,
        idToken: resIDToken,
        expiry: resExpiry,
        tokenSource: tokenSource);
  }

  Future<void> findAccount(Identity identity) async {
    var url = AppConstant.userAccountUrl;
    var response = await http.get(Uri.parse(url), headers: {
      "tid": identity.tid,
      "id_token": identity.idToken,
      "token_source": identity.tokenSource,
    });
    if (response.statusCode == 1000) {
      // refresh
      await validate(identity);
    }
    if (response.statusCode != 200) {
      throw 'Could not get auth request';
    }

    var decoded =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    print(decoded);
  }
}
