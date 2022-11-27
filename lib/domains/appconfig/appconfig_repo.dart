import 'dart:convert';
import 'dart:io';
import 'package:woong_front/domains/appconfig/appconfig.dart';
import 'package:http/http.dart' as http;

abstract class AppConfigRepo {
  Future<AppConfig> findAppConfigNoTx(String id);
}

class AppConfigHttp implements AppConfigRepo {
  String baseUrl;
  String bearerToken;
  late int defaultTimeout;

  AppConfigHttp(this.baseUrl, this.bearerToken, {int? defaultTimeout}) {
    this.defaultTimeout = defaultTimeout ?? 6;
  }

  @override
  Future<AppConfig> findAppConfigNoTx(String id) async {
    var response =
        await http.get(Uri.parse('$baseUrl/v1/woong/appconfig/$id'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $bearerToken',
      HttpHeaders.contentTypeHeader: 'application/json',
    }).timeout(Duration(seconds: defaultTimeout));
    if (response.statusCode >= 400 || response.statusCode < 100) {
      throw 'error ${response.statusCode}';
    }
    var decoded =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

    print(decoded);

    int status = decoded['status'];
    if (decoded['status'] != 200) {
      throw 'error $status';
    }
    // print(decoded['document']);
    return AppConfig.fromJson(decoded['document']);
  }
}
