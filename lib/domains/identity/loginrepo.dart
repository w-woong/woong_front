import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:woong_front/domains/identity/identity.dart';

class LoginRepo {
  LoginRepo();

  final String startUrl = 'https://localhost:5558/authrequest';
  final String waitUrl = 'https://localhost:5558/authrequest';
  final String authUrl = 'https://localhost:5558/authorize';
  final String validateUrl = 'https://localhost:5558/validate';

  // Future<http.Response> _getAuthRequest() async {
  //   return await http.get(Uri.parse(startUrl));
  // }
  Future<String> _getAuthRequest() async {
    var response = await http.get(Uri.parse(startUrl));
    if (response.statusCode != 200) {
      throw 'Could not get auth request';
    }
    var decoded = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    var authRequestID = decoded['id'] as String;
    return authRequestID;
  }

  Future<Identity> _waitAuthorized(String authRequestID) async {
    var response = await http.get(Uri.parse('$waitUrl/$authRequestID'));
    if (response.statusCode != 200) {
      throw 'Could not authorize';
    }

    var decoded = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    var idToken = decoded['id_token'] as String;
    var tid = decoded['tid'] as String;
    var expiry = decoded['expiry'] as int;
    return Identity(tid: tid, idToken: idToken, expiry: expiry);
  }

  // Future<void> _authorize(String authRequestID) async {
  //   bool res = await launchUrl(Uri.parse('$authUrl/$authRequestID'),
  //       mode: LaunchMode.externalApplication);

  //   if (!res) {
  //     throw 'Could not launch';
  //   }
  // }

  Future<void> _authorize(String authRequestID) async {
    bool res = await launchUrl(Uri.parse('$authUrl/$authRequestID'),
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

  Future<Identity> validate(String tid, String idToken) async {
    var response = await http.get(Uri.parse(validateUrl), headers: {
      "tid": tid,
      "id_token": idToken,
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
    return Identity(tid: resTID, idToken: resIDToken, expiry: resExpiry);
  }
}
