import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:woong_front/constants/constants.dart';
import 'package:woong_front/domains/common/httpbody.dart';
import 'package:woong_front/domains/order/model/cart.dart';
import 'package:woong_front/domains/order/model/cart_product.dart';
import 'package:woong_front/domains/order/port/cart_port.dart';

class CartHttp implements CartService {
  Dio client;

  CartHttp(this.client);

  @override
  Future<Cart> findCart() async {
    try {
      var response = await client.get(
        AppConstant.orderFindOrCreateCartPath,
        options: Options(headers: {
          Headers.contentTypeHeader: 'application/json; charset=utf-8'
        }),
      );

      var decoded = jsonDecode(response.data) as Map<String, dynamic>;
      if (decoded['document'] == null) {
        throw 'empty document';
      }

      return Cart.fromJson(decoded['document']);
    } finally {
      print('finally');
    }
  }

  @override
  Future<CartProduct> addCartProduct(CartProduct cartProduct) async {
    try {
      HttpBody reqBody = HttpBody();
      reqBody.document = cartProduct;
      var data = jsonEncode(reqBody);

      var response = await client.post(
        AppConstant.orderAddCartProductPath,
        options: Options(
          headers: {
            Headers.contentTypeHeader: 'application/json; charset=utf-8'
          },
        ),
        data: data,
      );

      var decoded = jsonDecode(response.data) as Map<String, dynamic>;
      var resBody = HttpBody.fromJson(decoded);
      if (resBody.document is! Map<String, dynamic>) {
        throw 'invalid response';
      }
      return CartProduct.fromJson(resBody.document as Map<String, dynamic>);
    } on DioError catch (e) {
      print(e.message);
      rethrow;
    } catch (e) {
      print(e.toString());
      rethrow;
    } finally {}
  }

  @override
  Future<Cart> testRefreshError() async {
    try {
      var response = await client.get('/test/order/cart',
          options: Options(headers: {
            Headers.contentTypeHeader: 'application/json; charset=utf-8'
          }));

      var decoded = jsonDecode(response.data) as Map<String, dynamic>;
      if (decoded['document'] == null) {
        throw 'empty document';
      }
      return Cart.fromJson(decoded['document']);
    } on DioError catch (e) {
      print(e.message);
      rethrow;
    } catch (e) {
      print(e.toString());
      rethrow;
    } finally {}
  }
}
