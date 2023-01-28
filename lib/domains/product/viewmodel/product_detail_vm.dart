import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:woong_front/commons/exceptions/auth_exceptions.dart';
import 'package:woong_front/domains/product/model/product.dart';
import 'package:woong_front/domains/product/port/product_port.dart';
import 'package:woong_front/domains/product/adapter/product_detail_http.dart';

class ProductDetailVM extends ChangeNotifier {
  ProductDetailService svc;
  Product product;

  ProductDetailVM({required this.svc, required this.product});

  Future<void> fetch(String id) async {
    try {
      product = await svc.findProductDetail(id);
      if (product.topImgUrlList.isEmpty) {
        product.topImgUrlList.add(product.imgUrl);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException(e.message);
      }
      throw e.message;
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }
}
