import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:woong_front/commons/exceptions/auth_exceptions.dart';
import 'package:woong_front/domains/appconfig/model/appconfig.dart';
import 'package:woong_front/domains/appconfig/adapter/appconfig_repo.dart';
import 'package:woong_front/domains/appconfig/port/appconfig_port.dart';

class AppConfigVM extends ChangeNotifier implements FetchAppConfigVM {
  AppConfigService svc;
  AppConfig appConfig;

  AppConfigVM({required this.svc}) : appConfig = AppConfig.empty();

  @override
  Future<void> fetch(String id) async {
    try {
      var appConfig = await svc.findAppConfig(id);
      if (appConfig.isEmpty()) {
        this.appConfig = AppConfig.empty();
      } else {
        this.appConfig = appConfig;
      }
    } on DioError catch (e) {
      // if (e.response?.statusCode == 401) {
      //   throw UnauthorizedException(e.message);
      // }
      // throw e.message;
      appConfig = AppConfig.empty();
    } catch (e) {
      // rethrow;
      appConfig = AppConfig.empty();
    } finally {
      notifyListeners();
    }
  }
}
