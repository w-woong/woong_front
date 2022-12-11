import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:woong_front/constants/routes.dart';

// models
import 'package:woong_front/domains/appconfig/appconfig.dart';
import 'package:woong_front/domains/appconfig/appconfig_repo.dart';
import 'package:woong_front/domains/appconfig/appconfig_vm.dart';
import 'package:woong_front/domains/home/home.dart';
import 'package:woong_front/domains/home/home_repo.dart';
import 'package:woong_front/domains/home/home_vm.dart';
import 'package:woong_front/domains/identity/loginrepo.dart';
import 'package:woong_front/domains/identity/loginvm.dart';
import 'package:woong_front/domains/notice/noticevm.dart';
import 'package:woong_front/domains/notice/noticerepo.dart';
import 'package:woong_front/domains/product/product.dart';
import 'package:woong_front/domains/product/product_detail_repo.dart';
import 'package:woong_front/domains/product/product_detail_vm.dart';
import 'package:woong_front/domains/promotion/promotion.dart';
import 'package:woong_front/domains/recommend/recommend.dart';

import 'package:woong_front/views/default/components/bottomnav.dart';
import 'package:woong_front/constants/constants.dart';
import 'package:woong_front/views/default/home/homeview.dart';
import 'package:woong_front/views/default/identity/loginview.dart';
import 'package:woong_front/views/default/product/product_detail_view.dart';
import 'package:woong_front/views/default/shopping/shoppingview.dart';
import 'package:woong_front/views/default/user/account_view.dart';
import 'package:woong_front/views/defaulttheme.dart';

class DefaultApp extends StatefulWidget {
  const DefaultApp({super.key});

  @override
  State<DefaultApp> createState() => _DefaultAppState();
}

const tabs = [
  ScaffoldWithNavBarTabItem(
    initialLocation: AppRouteConstant.home,
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  ScaffoldWithNavBarTabItem(
    initialLocation: AppRouteConstant.shopping,
    icon: Icon(Icons.shopping_cart),
    label: 'Shopping',
  ),
  ScaffoldWithNavBarTabItem(
    initialLocation: AppRouteConstant.user,
    icon: Icon(Icons.account_circle),
    label: 'Account',
  ),
];

class _DefaultAppState extends State<DefaultApp> {
  // late AppConfig appConfig;
  late AppConfigVM appConfigVM;

  late HomeVM homeVM;
  late ShortNoticeRepo shortNoticeRepo;
  late ShortNoticeVM shortNoticeVM;
  late PromotionVM promotionVM;
  late RecommendVM recommendVM;
  late ProductVM productVM;
  late ProductDetailVM productDetailVM;

  late LoginVM loginVM;

  @override
  void initState() {
    super.initState();

    appConfigVM = AppConfigVM(
        repo: AppConfigHttp(AppConstant.woongUrl, AppConstant.bearerToken));
    appConfigVM.fetch(AppConstant.appID);

    homeVM = HomeVM(
        homeRepo: HomeHttp(AppConstant.woongUrl, AppConstant.bearerToken));
    homeVM.fetch(AppConstant.appID);

    shortNoticeRepo = ShortNoticeRepo();
    shortNoticeVM = ShortNoticeVM(repo: shortNoticeRepo);
    shortNoticeVM.fetchNoticeList();
    promotionVM = PromotionVM(repo: PromotionRepo());
    promotionVM.fetchPromotionList();
    recommendVM = RecommendVM(repo: RecommendRepo());
    recommendVM.fetchRecommendList();
    productVM = ProductVM(repo: ProductRepo());
    productVM.fetch();
    productDetailVM =
        ProductDetailVM(repo: ProductDetailDummy(), product: Product.empty());

    loginVM = LoginVM(repo: LoginRepo());
  }

  @override
  Widget build(BuildContext context) {
    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final shellNavigatorKey = GlobalKey<NavigatorState>();

    final GoRouter router = GoRouter(
      // initialLocation: '/test',
      // initialLocation: '/shopping',
      // initialLocation: AppRouteConstant.home,
      initialLocation: AppRouteConstant.shopping,
      navigatorKey: rootNavigatorKey,
      routes: [
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) {
            return ScaffoldWithBottomNavBar(child: child);
            // return Container(
            //   child: child,
            // );
          },
          routes: <GoRoute>[
            GoRoute(
              path: AppRouteConstant.home,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: const HomeView(
                    bottomTabs: tabs,
                  ),
                  key: state.pageKey,
                  restorationId: state.pageKey.value,
                );
              },
              // builder: (BuildContext context, GoRouterState state) {
              //   return HomeView();
              // },
            ),
            GoRoute(
              path: AppRouteConstant.shopping,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: ShoppingView(
                    title: 'Shopping',
                    bottomTabs: tabs,
                  ),
                  // child: ProductSheetView(),
                );
              },
              routes: [
                GoRoute(
                  path: 'product',
                  builder: (context, state) {
                    return ProductDetailView(
                      product:
                          context.select((ProductVM vm) => vm.selectedProduct),
                      isSheet: false,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppRouteConstant.user,
              pageBuilder: (context, state) {
                bool isAuthorized = context.read<LoginVM>().isAuthorized();
                if (isAuthorized) {
                  return const NoTransitionPage(
                    child: LoginView(
                      bottomTabs: tabs,
                    ),
                  );
                }
                return const NoTransitionPage(
                  child: LoginView(
                    bottomTabs: tabs,
                  ),
                );
              },
            ),
            GoRoute(
              path: '/test',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: ProductDetailView(
                      product: Product.empty(),
                      isSheet: false,
                    ),
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
        // Provider(create: (context) => appConfig),
        ChangeNotifierProvider(create: (context) => appConfigVM),
        ChangeNotifierProvider(create: (context) => homeVM),
        ChangeNotifierProvider(create: (context) => shortNoticeVM),
        ChangeNotifierProvider(create: (context) => promotionVM),
        ChangeNotifierProvider(create: (context) => recommendVM),
        ChangeNotifierProvider(create: (context) => productVM),
        ChangeNotifierProvider(create: (context) => productDetailVM),
        ChangeNotifierProvider(create: (context) => loginVM),
      ],
      child: DefaultMaterialApp(router: router),
    );
  }
}

class DefaultMaterialApp extends StatefulWidget {
  RouterConfig<Object> router;
  DefaultMaterialApp({super.key, required this.router});

  @override
  State<DefaultMaterialApp> createState() => _DefaultMaterialAppState();
}

class _DefaultMaterialAppState extends State<DefaultMaterialApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: widget.router,
      title: context.select((AppConfigVM vm) => vm.appConfig.name),
      theme: defaultTheme,
      darkTheme: defaultThemeDark,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSwatch(
      //     primarySwatch: Colors.amber,
      //   ),
      //   brightness: Brightness.light,
      //   // primaryColor: Colors.orange[800],
      //   // focusColor: Colors.lightBlue[800],
      //   appBarTheme: AppBarTheme(
      //     backgroundColor: Theme.of(context).bottomAppBarColor,
      //     foregroundColor: Colors.black,
      //     titleTextStyle: TextStyle(
      //       color: Colors.black,
      //     ),
      //   ),
      //   // bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //   //   selectedItemColor: Colors.lightBlue[800],
      //   // ),
      // ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   colorScheme: ColorScheme.dark(),
      // ),
    );
  }
}
