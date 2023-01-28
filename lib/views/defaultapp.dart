import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:woong_front/commons/interceptors/auth_interceptor.dart';
import 'package:woong_front/commons/interceptors/validate_response_interceptor.dart';
import 'package:woong_front/constants/routes.dart';

// models
import 'package:woong_front/domains/appconfig/adapter/appconfig_repo.dart';
import 'package:woong_front/domains/appconfig/viewmodel/appconfig_vm.dart';
import 'package:woong_front/domains/home/adapter/home_http.dart';
import 'package:woong_front/domains/home/port/home_port.dart';
import 'package:woong_front/domains/home/viewmodel/home_vm.dart';
import 'package:woong_front/domains/identity/adapter/auth_http.dart';
import 'package:woong_front/domains/identity/adapter/token_refresh_http.dart';
import 'package:woong_front/domains/identity/loginvm.dart';
import 'package:woong_front/domains/identity/token_port.dart';
import 'package:woong_front/domains/identity/token_repo.dart';
import 'package:woong_front/domains/notice/viewmodel/noticevm.dart';
import 'package:woong_front/domains/notice/adapter/notice_dummy.dart';
import 'package:woong_front/domains/order/adapter/CartHttp.dart';
import 'package:woong_front/domains/order/port/cart_port.dart';
import 'package:woong_front/domains/order/viewmodel/cart_vm.dart';
import 'package:woong_front/domains/product/model/product.dart';
import 'package:woong_front/domains/product/product.dart';
import 'package:woong_front/domains/product/adapter/product_detail_http.dart';
import 'package:woong_front/domains/product/viewmodel/product_detail_vm.dart';
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
  late Dio productClient;
  late Dio userClient;
  late Dio orderClient;

  late TokenRefreshService tokenRefreshService;
  late AuthService googleAuthService;
  late TokenRepo tokenRepo;
  late UserService userService;
  late CartService cartService;
  late HomeService homeService;

  late AppConfigVM appConfigVM;

  late HomeVM homeVM;
  late ShortNoticeDummy shortNoticeRepo;
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

    productClient = Dio(
      BaseOptions(
        baseUrl: AppConstant.productUrl,
        connectTimeout: AppConstant.defaultConnectTimeout,
        receiveTimeout: AppConstant.defaultReceiveTimeout,
      ),
    );
    productClient.interceptors
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
    homeService = HomeHttp(woongClient);
    var productService = ProductDetailHttp(productClient);

    // ViewModel
    appConfigVM = AppConfigVM(svc: AppConfigHttp(woongClient));
    homeVM = HomeVM(homeSvc: homeService);

    shortNoticeRepo = ShortNoticeDummy();
    shortNoticeVM = ShortNoticeVM(svc: shortNoticeRepo);
    promotionVM = PromotionVM(repo: PromotionRepo());
    recommendVM = RecommendVM(repo: RecommendRepo());
    productVM = ProductVM(repo: ProductRepo());
    productDetailVM =
        ProductDetailVM(svc: productService, product: Product.empty());

    loginVM = LoginVM(
        googleAuthService: googleAuthService,
        tokenRepo: tokenRepo,
        userService: userService);

    cartVM = CartVM(cartService);

    appConfigVM.fetch(AppConstant.appID);
    loginVM.checkAuthorized();

    // homeVM.fetch(AppConstant.appID);
    // shortNoticeVM.fetchNoticeList();
    // promotionVM.fetchPromotionList();
    // recommendVM.fetchRecommendList();
    // productVM.fetch();
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
                    path: AppRouteConstant.home,
                    bottomTabs: DefaultAppNavBar.tabs,
                  ),
                  key: state.pageKey,
                  restorationId: state.pageKey.value,
                );
              },
              // builder: (BuildContext context, GoRouterState state) {
              //   return HomeView();
              // },
              routes: [
                GoRoute(
                  path: 'product',
                  builder: (context, state) {
                    Product product = state.extra as Product;
                    return ProductDetailView(product: product, isSheet: false);
                  },
                ),
              ],
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
    String title = context.select((AppConfigVM vm) => vm.appConfig.name);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: widget.router,
      title: title,
      theme: defaultTheme,
      darkTheme: defaultThemeDark,
    );
  }
}
