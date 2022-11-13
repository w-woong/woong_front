import 'package:flutter/material.dart';

class Home {
  final String title;
  double position;
  bool isLoading;
  Home({required this.title})
      : position = 0,
        isLoading = false;
}

class HomeVM extends ChangeNotifier {
  Home home;

  HomeVM({required this.home});

  void loading() {
    home.isLoading = true;
    notifyListeners();
  }

  void finishedLoading() {
    home.isLoading = false;
    notifyListeners();
  }
}
