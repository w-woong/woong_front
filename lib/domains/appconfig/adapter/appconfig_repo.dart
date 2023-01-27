import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:woong_front/constants/constants.dart';
import 'package:woong_front/domains/appconfig/model/appconfig.dart';
import 'package:http/http.dart' as http;
import 'package:woong_front/domains/appconfig/port/appconfig_port.dart';

class AppConfigHttp implements AppConfigService {
  Dio client;

  AppConfigHttp(this.client);

  @override
  Future<AppConfig> findAppConfig(String id) async {
    var response = await client.get(
      '${AppConstant.woongAppconfigPath}/$id',
      options: Options(
        headers: {Headers.contentTypeHeader: 'application/json; charset=utf-8'},
      ),
    );
    var decoded = jsonDecode(response.data) as Map<String, dynamic>;
    if (decoded['document'] == null) {
      throw 'empty document';
    }

    return AppConfig.fromJson(decoded['document']);
  }
}
