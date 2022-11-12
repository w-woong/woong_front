import 'dart:io';

import 'package:flutter/material.dart';

// for usePathUrlStrategy();
import 'package:flutter_web_plugins/url_strategy.dart';

// app
import 'package:woong_front/views/defaultapp.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  usePathUrlStrategy();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return ExampleHomeView();
    return const DefaultApp();
  }
}
