import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:woong_front/domains/common/httpbody.dart';

class ValidateResponseInterceptor extends Interceptor {
  // @override
  // void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
  //   print('HandleResponseInterceptor: onRequest');
  //   return super.onRequest(options, handler);
  // }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      if (jsonDecode(response.data) is Map<String, dynamic>) {
        var decoded = jsonDecode(response.data) as Map<String, dynamic>;
        var resBody = HttpBody.fromJson(decoded);
        // var status = decoded['status'] ?? 404;
        // var message = decoded['message'] ?? 'unknown error';
        var status = resBody.status ?? 404;
        if (status != 200) {
          return handler.reject(
              DioError(
                  requestOptions: response.requestOptions,
                  response: response,
                  error: resBody.message ?? 'unknown error'),
              false);
        }
        return super.onResponse(response, handler);
      }
      throw 'response format is not valid';
    } catch (e) {
      return handler.reject(
          DioError(
              requestOptions: response.requestOptions,
              response: response,
              error: e),
          false);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print('HandleResponseInterceptor: onError');
    if (err.response?.data != null &&
        err.response?.data is Map<String, dynamic>) {
      var decoded = jsonDecode(err.response?.data) as Map<String, dynamic>;
      var status = decoded['status'] ?? 404;
      var message = decoded['message'] ?? 'unknown error';
      // throw '$message(status:$status)';
      return super.onError(
          DioError(
            requestOptions: err.requestOptions,
            response: err.response,
            error: '$message(status:$status)',
          ),
          handler);
    }

    return super.onError(err, handler);
  }
}
