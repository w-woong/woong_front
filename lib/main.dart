import 'package:flutter/material.dart';

// for usePathUrlStrategy();
import 'package:flutter_web_plugins/url_strategy.dart';

// app
import 'package:woong_front/views/defaultapp.dart';

void main() {
  usePathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return ExampleHomeView();
    return DefaultApp();
  }
}
