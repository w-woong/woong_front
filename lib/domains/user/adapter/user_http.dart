import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:woong_front/constants/constants.dart';
import 'package:woong_front/domains/user/user.dart';
import 'package:woong_front/domains/user/user_port.dart';

class UserHttp implements UserService {
  Dio client;
  UserHttp(this.client);

  @override
  Future<User> findUserAccount() async {
    try {
      var response = await client.get(
        AppConstant.userAccountUrl,
        options: Options(
          headers: {
            Headers.contentTypeHeader: 'application/json',
          },
        ),
      );
      var decoded = jsonDecode(response.data) as Map<String, dynamic>;
      var status = decoded['status'] ?? 404;
      var message = decoded['message'] ?? 'unknown error';
      if (status != 200) {
        throw '$message(status:$status)';
      }
      print('UserHttp: $decoded["document"]');
      if (decoded["document"] == null) {
        return User.empty();
      }
      return User.fromJson(decoded['document']);
    } on DioError catch (e) {
      if (e.response != null) {
        var decoded = jsonDecode(e.response?.data) as Map<String, dynamic>;
        var status = decoded['status'] ?? 404;
        var message = decoded['message'] ?? 'unknown error';
        throw '$message(status:$status)';
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}
