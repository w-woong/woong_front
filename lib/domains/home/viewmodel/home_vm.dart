import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:woong_front/commons/exceptions/auth_exceptions.dart';
import 'package:woong_front/domains/home/model/home.dart';
import 'package:woong_front/domains/home/adapter/home_http.dart';
import 'package:woong_front/domains/home/port/home_port.dart';

class HomeVM extends ChangeNotifier {
  HomeService homeSvc;
  Home home;

  double position = 0.0;

  HomeVM({required this.homeSvc}) : home = Home.empty();

  Future<void> fetch(String id) async {
    try {
      var home = await homeSvc.findHomeByAppConfigID(id);
      this.home = home;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException(e.message);
      }
      throw e.message;
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }
}
