import 'package:flutter/material.dart';

class AppConfigModel {
  final String title;

  AppConfigModel({required this.title});
}

class AppConfigRepo {
  AppConfigModel? config;

  AppConfigRepo({this.config});

  AppConfigModel? get getConfig {
    return config;
  }

  Future<AppConfigModel> readConfig() async {
    AppConfigModel m = await Future.delayed(Duration(seconds: 1), () {
      return AppConfigModel(title: 'my home');
    });

    return m;
  }
}

class AppConfigProv extends ChangeNotifier {
  final AppConfigRepo repo;
  AppConfigModel model;

  AppConfigProv({required this.repo, required this.model});

  void getConfig() async {
    model = await repo.readConfig();
    notifyListeners();
  }
}
