import 'package:flutter/material.dart';
import 'package:woong_front/domains/home/home.dart';

class HomeVM extends ChangeNotifier {
  Home home;
  double loadingAreaHeight = 0.0;
  Duration loadingAnimDuration = const Duration(milliseconds: 350);

  HomeVM({required this.home});

  void loading() {
    home.isLoading = true;
    loadingAreaHeight = 100;
    notifyListeners();
  }

  void finishedLoading() {
    home.isLoading = false;
    loadingAreaHeight = 0;
    notifyListeners();
  }
}
