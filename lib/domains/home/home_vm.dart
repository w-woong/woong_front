import 'package:flutter/material.dart';
import 'package:woong_front/domains/home/home.dart';
import 'package:woong_front/domains/home/home_repo.dart';

class HomeVM extends ChangeNotifier {
  HomeRepo homeRepo;
  Home home;
  double loadingAreaHeight = 0.0;
  Duration loadingAnimDuration = const Duration(milliseconds: 350);

  double position = 0.0;
  bool isLoading = false;

  HomeVM({required this.homeRepo}) : home = Home.empty();

  void loading() {
    isLoading = true;
    loadingAreaHeight = 100;
    notifyListeners();
  }

  void finishedLoading() {
    isLoading = false;
    loadingAreaHeight = 0;
    notifyListeners();
  }

  Future<void> fetch(String id) async {
    var home = await homeRepo.findHomeByAppConfigID(id);
    this.home = home;
    // print(home);
    notifyListeners();
  }
}
