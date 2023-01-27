import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:woong_front/constants/constants.dart';
import 'package:woong_front/domains/home/model/home.dart';
import 'package:http/http.dart' as http;
import 'package:woong_front/domains/home/port/home_port.dart';

class HomeHttp implements HomeService {
  Dio client;

  // String baseUrl;
  // String bearerToken;
  // late int defaultTimeout;

  HomeHttp(this.client);
  @override
  Future<Home> findHomeByAppConfigID(String appConfigID) async {
    var response = await client
        .get(
          '${AppConstant.woongHomeAppconfigPath}/$appConfigID',
          options: Options(headers: {
            Headers.contentTypeHeader: 'application/json; charset=utf-8'
          }),
        )
        .timeout(const Duration(seconds: 15));

    var decoded = jsonDecode(response.data) as Map<String, dynamic>;
    if (decoded['document'] == null) {
      throw 'empty document';
    }

    return Home.fromJson(decoded['document']);
  }

  // @override
  // Future<Home> findHomeByAppConfigID(String appConfigID) async {
  //   var response = await http.get(
  //       Uri.parse('$baseUrl/v1/woong/home/appconfig/$appConfigID'),
  //       headers: {
  //         HttpHeaders.authorizationHeader: 'Bearer $bearerToken',
  //         HttpHeaders.contentTypeHeader: 'application/json',
  //       }).timeout(Duration(seconds: defaultTimeout));
  //   if (response.statusCode >= 400 || response.statusCode < 100) {
  //     throw 'error ${response.statusCode}';
  //   }
  //   var decoded =
  //       jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
  //   print(decoded);

  //   int status = decoded['status'];
  //   if (decoded['status'] != 200) {
  //     throw 'error $status';
  //   }

  //   return Home.fromJson(decoded['document']);
  // }
}
