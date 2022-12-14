import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:woong_front/domains/appconfig/appconfig.dart';
import 'package:http/http.dart' as http;

abstract class AppConfigRepo {
  Future<AppConfig> findAppConfig(String id);
}

class AppConfigHttp implements AppConfigRepo {
  Dio client;
  // String baseUrl;
  // String bearerToken;
  // late int defaultTimeout;

  AppConfigHttp(this.client);

  @override
  Future<AppConfig> findAppConfig(String id) async {
    try {
      var response = await client.get(
        '/v1/woong/appconfig/$id',
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

      return AppConfig.fromJson(decoded['document']);
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
}
