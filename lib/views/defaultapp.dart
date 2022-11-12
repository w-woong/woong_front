import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:woong_front/domains/appconfig/appconfig.dart';

// models
import 'package:woong_front/domains/home/home.dart';
import 'package:woong_front/views/default/components/bottomnav.dart';
import 'package:woong_front/views/default/home/homeview.dart';
import 'package:woong_front/views/default/identity/login.dart';

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
    final _rootNavigatorKey = GlobalKey<NavigatorState>();
    final _shellNavigatorKey = GlobalKey<NavigatorState>();

    final GoRouter _router = GoRouter(
        initialLocation: '/home',
        navigatorKey: _rootNavigatorKey,
        routes: [
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              return ScaffoldWithBottomNavBar(child: child);
            },
            routes: <GoRoute>[
              GoRoute(
                path: '/home',
                pageBuilder: (context, state) {
                  return NoTransitionPage(child: HomeView());
                },
                // builder: (BuildContext context, GoRouterState state) {
                //   return HomeView();
                // },
              ),
              GoRoute(
                path: '/login',
                pageBuilder: (context, state) {
                  return NoTransitionPage(child: LoginView());
                },
                // builder: (BuildContext context, GoRouterState state) {
                //   return LoginView();
                // },
              ),
            ],
          ),
        ]
        // routes: <GoRoute>[
        //   GoRoute(
        //     path: '/',
        //     builder: (BuildContext context, GoRouterState state) {
        //       return HomeView();
        //     },
        //   ),
        //   GoRoute(
        //     path: '/login',
        //     builder: (BuildContext context, GoRouterState state) {
        //       return LoginView();
        //     },
        //   ),
        // ],
        );

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
}

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({super.key, required this.child});
  final Widget child;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavV2(),
    );
  }
}
