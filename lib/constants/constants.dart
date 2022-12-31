class AppConstant {
  static const defaultConnectTimeout = 3000;
  static const defaultReceiveTimeout = 15000;

  static const bearerToken =
      'ab2316584873095f017f6dfa7a9415794f563fcc473eb3fe65b9167e37fd5a4b';
  static const appID = 'b69aa108-f12e-4fa0-bf4f-ba002c11a670';

  static const woongUrl = 'http://192.168.0.92:49001';
  static const authBaseUrl = 'https://192.168.0.92:5558';
  static const userBaseUrl = 'https://192.168.0.92:8080';
  static const orderBaseUrl = 'https://192.168.0.92:49003';

  static const authRefreshPath = '/v1/auth/validate';
  static const authPath = '/v1/auth/authorize';
  static const authRetrievePath = '/v1/auth/request';
  static const authWaitPath = '/v1/auth/request';

  static const userAccountUrl = '/v1/user/account';

  static const orderFindOrCreateCartPath = '/v1/order/cart/_find-or-create';
  static const orderAddCartProductPath = '/v1/order/cart/product';
  // static const authStartUrl =
  //     'https://localhost:5558/v1/auth/request/{token_source}';
  // static const authWaitUrl =
  //     'https://localhost:5558/v1/auth/request/{token_source}';
  // static const authUrl =
  //     'https://localhost:5558/v1/auth/authorize/{token_source}';
  // static const authValidateUrl =
  // 'https://localhost:5558/v1/auth/validate/{token_source}';

}
