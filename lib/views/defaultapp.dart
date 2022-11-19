import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

// models
import 'package:woong_front/domains/appconfig/appconfig.dart';
import 'package:woong_front/domains/home/home.dart';
import 'package:woong_front/domains/home/homevm.dart';
import 'package:woong_front/domains/identity/loginrepo.dart';
import 'package:woong_front/domains/identity/loginvm.dart';
import 'package:woong_front/domains/notice/noticevm.dart';
import 'package:woong_front/domains/notice/noticerepo.dart';
import 'package:woong_front/domains/product/product.dart';
import 'package:woong_front/domains/promotion/promotion.dart';
import 'package:woong_front/domains/recommend/recommend.dart';

import 'package:woong_front/views/default/components/bottomnav.dart';
import 'package:woong_front/views/default/home/homeview.dart';
import 'package:woong_front/views/default/identity/loginview.dart';
import 'package:woong_front/views/default/product/product_detail.dart';
import 'package:woong_front/views/default/product/product_sheet.dart';
import 'package:woong_front/views/default/shopping/shoppingview.dart';

class DefaultApp extends StatefulWidget {
  const DefaultApp({super.key});

  @override
  State<DefaultApp> createState() => _DefaultAppState();
}

class _DefaultAppState extends State<DefaultApp> {
  late AppConfig appConfig;

  late HomeVM homeVM;
  late ShortNoticeRepo shortNoticeRepo;
  late ShortNoticeVM shortNoticeVM;
  late PromotionVM promotionVM;
  late RecommendVM recommendVM;
  late ProductVM productVM;

  late LoginVM loginVM;

  @override
  void initState() {
    super.initState();
    appConfig = AppConfig(title: 'Default App');

    homeVM = HomeVM(home: Home(title: 'My Home'));
    shortNoticeRepo = ShortNoticeRepo();
    shortNoticeVM = ShortNoticeVM(repo: shortNoticeRepo);
    shortNoticeVM.fetchNoticeList();
    promotionVM = PromotionVM(repo: PromotionRepo());
    promotionVM.fetchPromotionList();
    recommendVM = RecommendVM(repo: RecommendRepo());
    recommendVM.fetchRecommendList();
    productVM = ProductVM(repo: ProductRepo());
    productVM.fetch();

    loginVM = LoginVM(repo: LoginRepo());
  }

  @override
  Widget build(BuildContext context) {
    final _rootNavigatorKey = GlobalKey<NavigatorState>();
    final _shellNavigatorKey = GlobalKey<NavigatorState>();

    final GoRouter _router = GoRouter(
      initialLocation: '/shopping',
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
                return NoTransitionPage(
                  child: HomeView(key: UniqueKey()),
                  key: state.pageKey,
                  restorationId: state.pageKey.value,
                );
              },
              // builder: (BuildContext context, GoRouterState state) {
              //   return HomeView();
              // },
            ),
            GoRoute(
              path: '/shopping',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  // child: ShoppingView(),
                  child: ProductSheetView(),
                );
              },
              routes: [
                GoRoute(
                  path: 'product',
                  builder: (context, state) => ProductSheetView(),
                ),
              ],
            ),
            GoRoute(
              path: '/login',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: LoginView(),
                    key: state.pageKey,
                    restorationId: state.pageKey.value);
              },
            ),
          ],
        ),
      ],
    );

    return MultiProvider(
      providers: [
        Provider(create: (context) => appConfig),
        ChangeNotifierProvider(create: (context) => homeVM),
        ChangeNotifierProvider(create: (context) => shortNoticeVM),
        ChangeNotifierProvider(create: (context) => promotionVM),
        ChangeNotifierProvider(create: (context) => recommendVM),
        ChangeNotifierProvider(create: (context) => productVM),
        ChangeNotifierProvider(create: (context) => loginVM),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
        title: 'Woong',
        theme: ThemeData(
          brightness: Brightness.light,
          // primaryColor: Colors.lightBlue[800],
          // focusColor: Colors.lightBlue[800],
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            foregroundColor: Colors.black,
            titleTextStyle: TextStyle(
              color: Colors.black,
            ),
          ),
          // bottomNavigationBarTheme: BottomNavigationBarThemeData(
          //   selectedItemColor: Colors.lightBlue[800],
          // ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
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
