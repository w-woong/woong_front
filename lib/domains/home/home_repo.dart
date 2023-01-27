import 'dart:convert';
import 'dart:io';

import 'package:woong_front/domains/home/model/home.dart';
import 'package:http/http.dart' as http;

abstract class HomeRepo {
  Future<Home> findHomeByAppConfigID(String appConfigID);
}

class HomeHttp implements HomeRepo {
  String baseUrl;
  String bearerToken;
  late int defaultTimeout;

  HomeHttp(this.baseUrl, this.bearerToken, {int? defaultTimeout}) {
    this.defaultTimeout = defaultTimeout ?? 6;
  }

  @override
  Future<Home> findHomeByAppConfigID(String appConfigID) async {
    var response = await http.get(
        Uri.parse('$baseUrl/v1/woong/home/appconfig/$appConfigID'),
        headers: {
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

    return Home.fromJson(decoded['document']);
  }
}
