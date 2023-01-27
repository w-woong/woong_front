import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:woong_front/commons/interceptors/auth_interceptor.dart';
import 'package:woong_front/commons/interceptors/validate_response_interceptor.dart';
import 'package:woong_front/constants/routes.dart';

// models
import 'package:woong_front/domains/appconfig/appconfig.dart';
import 'package:woong_front/domains/appconfig/appconfig_repo.dart';
import 'package:woong_front/domains/appconfig/appconfig_vm.dart';
import 'package:woong_front/domains/home/home.dart';
import 'package:woong_front/domains/home/home_repo.dart';
import 'package:woong_front/domains/home/home_vm.dart';
import 'package:woong_front/domains/identity/adapter/auth_http.dart';
import 'package:woong_front/domains/identity/adapter/token_refresh_http.dart';
import 'package:woong_front/domains/identity/loginvm.dart';
import 'package:woong_front/domains/identity/token_port.dart';
import 'package:woong_front/domains/identity/token_repo.dart';
import 'package:woong_front/domains/notice/noticevm.dart';
import 'package:woong_front/domains/notice/noticerepo.dart';
import 'package:woong_front/domains/order/adapter/CartHttp.dart';
import 'package:woong_front/domains/order/port/cart_port.dart';
import 'package:woong_front/domains/order/viewmodel/cart_vm.dart';
import 'package:woong_front/domains/product/product.dart';
import 'package:woong_front/domains/product/product_detail_repo.dart';
import 'package:woong_front/domains/product/product_detail_vm.dart';
import 'package:woong_front/domains/promotion/promotion.dart';
import 'package:woong_front/domains/recommend/recommend.dart';
import 'package:woong_front/domains/user/adapter/user_http.dart';
import 'package:woong_front/domains/user/user_port.dart';
import 'package:woong_front/views/default/cart/cart_view.dart';

import 'package:woong_front/views/default/components/bottomnav.dart';
import 'package:woong_front/constants/constants.dart';
import 'package:woong_front/views/default/home/homeview.dart';
import 'package:woong_front/views/default/identity/loginview.dart';
import 'package:woong_front/views/default/payment/payment_view.dart';
import 'package:woong_front/views/default/product/product_detail_view.dart';
import 'package:woong_front/views/default/shopping/shoppingview.dart';
import 'package:woong_front/views/default/testviews/test_view.dart';
import 'package:woong_front/views/default/user/account_view.dart';
import 'package:woong_front/views/defaulttheme.dart';
import 'package:woong_front/views/defaultapp_navbartabs.dart';

class DefaultApp extends StatefulWidget {
  const DefaultApp({super.key});

  @override
  State<DefaultApp> createState() => _DefaultAppState();
}

class _DefaultAppState extends State<DefaultApp> {
  late FlutterSecureStorage secureStorage;

  late Dio refreshOnlyClient;
  late Dio authClient;
  late Dio woongClient;
  late Dio userClient;
  late Dio orderClient;

  late TokenRefreshService tokenRefreshService;
  late AuthService googleAuthService;
  late TokenRepo tokenRepo;
  late UserService userService;
  late CartService cartService;

  late AppConfigVM appConfigVM;

  late HomeVM homeVM;
  late ShortNoticeRepo shortNoticeRepo;
  late ShortNoticeVM shortNoticeVM;
  late PromotionVM promotionVM;
  late RecommendVM recommendVM;
  late ProductVM productVM;
  late ProductDetailVM productDetailVM;

  late LoginVM loginVM;
  late CartVM cartVM;

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  IOSOptions iOptions =
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);
  @override
  void initState() {
    super.initState();

    // storage
    secureStorage = FlutterSecureStorage(
        aOptions: _getAndroidOptions(), iOptions: iOptions);
    tokenRepo = TokenSecureStorage(secureStorage);

    // client
    refreshOnlyClient = Dio(
      BaseOptions(
        baseUrl: AppConstant.authBaseUrl,
        connectTimeout: AppConstant.defaultConnectTimeout,
        receiveTimeout: AppConstant.defaultReceiveTimeout,
      ),
    );
    // authClient.interceptors.add(RefreshIDTokenInterceptor(tokenRepo));
    tokenRefreshService = TokenRefreshHttp(refreshOnlyClient);

    authClient = Dio(
      BaseOptions(
        baseUrl: AppConstant.authBaseUrl,
        connectTimeout: AppConstant.defaultConnectTimeout,
        receiveTimeout: AppConstant.defaultReceiveTimeout,
      ),
    );
    googleAuthService = AuthHttp(authClient, 'google');

    // client
    var options = BaseOptions(
      baseUrl: AppConstant.woongUrl,
      connectTimeout: AppConstant.defaultConnectTimeout,
      receiveTimeout: AppConstant.defaultReceiveTimeout,
    );
    woongClient = Dio(options);
    woongClient.interceptors
        .add(AuthBearerInterceptor(AppConstant.bearerToken));

    userClient = Dio(
      BaseOptions(
        baseUrl: AppConstant.userBaseUrl,
        connectTimeout: AppConstant.defaultConnectTimeout,
        receiveTimeout: AppConstant.defaultReceiveTimeout,
      ),
    );
    userClient.interceptors
        .add(AuthIDTokenInterceptor(tokenRepo, tokenRefreshService));

    orderClient = Dio(BaseOptions(
      baseUrl: AppConstant.orderBaseUrl,
      connectTimeout: AppConstant.defaultConnectTimeout,
      receiveTimeout: AppConstant.defaultReceiveTimeout,
    ));
    orderClient.interceptors
        .add(AuthIDTokenInterceptor(tokenRepo, tokenRefreshService));
    orderClient.interceptors.add(ValidateResponseInterceptor());

    // service
    userService = UserHttp(userClient);
    cartService = CartHttp(orderClient);

    appConfigVM = AppConfigVM(repo: AppConfigHttp(woongClient));
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

    loginVM = LoginVM(
        googleAuthService: googleAuthService,
        tokenRepo: tokenRepo,
        userService: userService);
    loginVM.checkAuthorized();

    cartVM = CartVM(cartService);
  }

  @override
  Widget build(BuildContext context) {
    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final shellNavigatorKey = GlobalKey<NavigatorState>();

    final GoRouter router = GoRouter(
      // initialLocation: '/test',
      // initialLocation: '/shopping',
      initialLocation: AppRouteConstant.home,
      // initialLocation: AppRouteConstant.shopping,
      // initialLocation: AppRouteConstant.cart,
      // initialLocation: AppRouteConstant.payment,
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
                    bottomTabs: DefaultAppNavBar.tabs,
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
                    bottomTabs: DefaultAppNavBar.tabs,
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
                // bool isAuthorized = context.read<LoginVM>().isAuthorized();
                // if (isAuthorized) {
                //   return const NoTransitionPage(
                //     child: LoginView(
                //       bottomTabs: tabs,
                //     ),
                //   );
                // }
                return const NoTransitionPage(
                  child: LoginView(
                    bottomTabs: DefaultAppNavBar.tabs,
                  ),
                );
              },
            ),
            GoRoute(
              path: AppRouteConstant.cart,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: CartView(
                    bottomTabs: DefaultAppNavBar.tabs,
                    title: 'Cart',
                  ),
                );
              },
              routes: [
                GoRoute(
                  path: 'payment',
                  builder: (context, state) {
                    return PaymentView(
                      bottomTabs: DefaultAppNavBar.tabs,
                      title: 'Payment',
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppRouteConstant.payment,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: PaymentView(
                    bottomTabs: DefaultAppNavBar.tabs,
                    title: 'Payment',
                  ),
                );
              },
            ),
            GoRoute(
              path: '/test',
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: MyTestView(
                    bottomTabs: DefaultAppNavBar.tabs,
                  ),
                );
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
        ChangeNotifierProvider(create: (context) => cartVM),
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
