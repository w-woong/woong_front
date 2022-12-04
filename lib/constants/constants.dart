class AppConstant {
  static const woongUrl = 'http://localhost:49001';
  static const bearerToken =
      'ab2316584873095f017f6dfa7a9415794f563fcc473eb3fe65b9167e37fd5a4b';
  static const appID = 'b69aa108-f12e-4fa0-bf4f-ba002c11a670';

  static const authStartUrl =
      'https://localhost:5558/v1/auth/request/{token_source}';
  static const authWaitUrl =
      'https://localhost:5558/v1/auth/request/{token_source}';
  static const authUrl =
      'https://localhost:5558/v1/auth/authorize/{token_source}';
  static const authValidateUrl =
      'https://localhost:5558/v1/auth/validate/{token_source}';
}
