import 'package:flutter/material.dart';

class Home {
  final String title;
  double position;
  bool isLoading;
  Home({required this.title})
      : position = 0,
        isLoading = false;
}
