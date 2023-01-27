import 'package:woong_front/domains/appconfig/model/appconfig.dart';

abstract class AppConfigService {
  Future<AppConfig> findAppConfig(String id);
}

abstract class FetchAppConfigVM {
  Future<void> fetch(String id);
}
