import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:woong_front/commons/exceptions/auth_exceptions.dart';
import 'package:woong_front/domains/identity/token.dart';
import 'package:woong_front/domains/identity/token_port.dart';
import 'package:woong_front/domains/identity/token_repo.dart';

class AuthIDTokenInterceptor extends QueuedInterceptor {
  TokenRepo tokenRepo;
  TokenRefreshService tokenRefreshService;

  AuthIDTokenInterceptor(this.tokenRepo, this.tokenRefreshService);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print(
        'AuthIDTokenInterceptor: REQUEST[${options.method}] => PATH: ${options.path}');

    var token = await tokenRepo.read();
    options.headers['tid'] = token.tid;
    options.headers['id_token'] = token.idToken;
    options.headers['token_source'] = token.tokenSource;
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'AuthIDTokenInterceptor: RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print(
        'AuthIDTokenInterceptor: ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (err.response?.statusCode != 401) {
      print('return not 401');
      return super.onError(err, handler);
    }

    var body = err.response?.data;

    // var decoded = json.decode(body).cast<Map<String, dynamic>>();
    var decoded = jsonDecode(body) as Map<String, dynamic>;
    var status = decoded['status'] ?? 404;
    if (status != 1000) {
      // print('return not 1000');
      return super.onError(err, handler);

      // throw UnauthorizedException(err.message);
    }

    try {
      var refreshedToken = await tokenRefreshService.refresh(Token(
          tid: err.requestOptions.headers['tid'],
          idToken: err.requestOptions.headers['id_token'],
          expiry: 0,
          tokenSource: err.requestOptions.headers['token_source']));
      await tokenRepo.create(refreshedToken);
    } catch (e) {
      await tokenRepo.delete();
      return super.onError(err, handler);
    }

    try {
      var response = await requestAgain(err);
      return handler.resolve(response);
    } catch (e) {
      return handler.reject(DioError(
          requestOptions: err.requestOptions,
          response: err.response,
          error: e));
      // return super.onError(err, handler);
    }
  }

  Future<Response> requestAgain(DioError err) async {
    var dio = Dio();
    dio.options.baseUrl = err.requestOptions.baseUrl;
    dio.options.connectTimeout = err.requestOptions.connectTimeout;
    dio.options.receiveTimeout = err.requestOptions.receiveTimeout;

    var token = await tokenRepo.read();

    var options = Options(method: err.requestOptions.method);
    options.headers = err.requestOptions.headers;
    options.headers!['tid'] = token.tid;
    options.headers!['id_token'] = token.idToken;
    options.headers!['token_source'] = token.tokenSource;
    return await dio.request(
      err.requestOptions.path,
      options: options,
      data: err.requestOptions.data,
      queryParameters: err.requestOptions.queryParameters,
    );
  }
}

class AuthBearerInterceptor extends Interceptor {
  String bearerToken;
  AuthBearerInterceptor(this.bearerToken);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer $bearerToken';
    return super.onRequest(options, handler);
  }

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   return super.onResponse(response, handler);
  // }

  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) async {
  //   return super.onError(err, handler);
  // }
}

// class HandleResponseInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     print('HandleResponseInterceptor: onRequest');
//     return super.onRequest(options, handler);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     print('HandleResponseInterceptor: onResponse');
//     return super.onResponse(response, handler);
//   }

//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) async {
//     print('HandleResponseInterceptor: onError');
//     return super.onError(err, handler);
//   }
// }
