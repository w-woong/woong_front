import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    print('REQUEST[${options.method}] => PATH: ${options.path}');

    var token = await tokenRepo.read();
    options.headers['tid'] = token.tid;
    options.headers['id_token'] = token.idToken;
    options.headers['token_source'] = token.tokenSource;
    return super.onRequest(options, handler);
  }

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   print(
  //       'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
  //   return super.onResponse(response, handler);
  // }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print(
        'TestInterceptor: ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (err.response?.statusCode != 401) {
      return super.onError(err, handler);
    }

    var body = err.response?.data;

    // var decoded = json.decode(body).cast<Map<String, dynamic>>();
    var decoded = jsonDecode(body) as Map<String, dynamic>;
    var status = decoded['status'] ?? 404;
    if (status != 1000) {
      return super.onError(err, handler);
    }

    try {
      var refreshedToken = await tokenRefreshService.refresh(Token(
          tid: err.requestOptions.headers['tid'],
          idToken: err.requestOptions.headers['tid'],
          expiry: 0,
          tokenSource: err.requestOptions.headers['id_token']));
      await tokenRepo.create(refreshedToken);
    } catch (e) {
      await tokenRepo.delete();
      return super.onError(err, handler);
    }

    var response = await requestAgain(err);
    return handler.resolve(response);
  }

  Future<Response> requestAgain(DioError err) async {
    var dio = Dio();
    dio.options.baseUrl = err.requestOptions.baseUrl;
    dio.options.connectTimeout = err.requestOptions.connectTimeout;
    dio.options.receiveTimeout = err.requestOptions.receiveTimeout;

    return await dio.request(
      err.requestOptions.path,
      options: Options(
        method: err.requestOptions.method,
        headers: err.requestOptions.headers,
      ),
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
