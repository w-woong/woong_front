import 'package:flutter/material.dart';
import 'package:woong_front/domains/appconfig/appconfig.dart';
import 'package:woong_front/domains/appconfig/appconfig_repo.dart';

class AppConfigVM extends ChangeNotifier {
  AppConfigRepo repo;
  AppConfig appConfig;

  AppConfigVM({required this.repo}) : appConfig = AppConfig.empty();

  Future<void> fetch(String id) async {
    try {
      var appConfig = await repo.findAppConfigNoTx(id);
      if (appConfig.isEmpty()) {
        this.appConfig = AppConfig.empty();
      } else {
        this.appConfig = appConfig;
      }
    } catch (e) {
      appConfig = AppConfig.empty();
    } finally {
      notifyListeners();
    }
  }
}
