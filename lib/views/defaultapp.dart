import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:woong_front/domains/appconfig/appconfig.dart';

// models
import 'package:woong_front/domains/home/home.dart';
import 'package:woong_front/views/default/home/homeview.dart';

class DefaultApp extends StatefulWidget {
  const DefaultApp({super.key});

  @override
  State<DefaultApp> createState() => _DefaultAppState();
}

class _DefaultAppState extends State<DefaultApp> {
  late AppConfig appConfig;

  @override
  void initState() {
    super.initState();
    appConfig = AppConfig(title: 'Default App');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => appConfig),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
        title: 'Woong',
      ),
    );
  }

  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return HomeView();
        },
      ),
    ],
  );
}
