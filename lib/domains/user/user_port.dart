import 'dart:convert';

import 'package:woong_front/domains/user/user.dart';

abstract class UserService {
  Future<User> findUserAccount();
}
