import 'package:woong_front/domains/home/model/home.dart';

abstract class HomeService {
  Future<Home> findHomeByAppConfigID(String appConfigID);
}
