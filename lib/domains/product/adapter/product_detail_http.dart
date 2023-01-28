import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:woong_front/constants/constants.dart';
import 'package:woong_front/domains/product/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:woong_front/domains/product/port/product_port.dart';

class ProductDetailHttp implements ProductDetailService {
  Dio client;

  ProductDetailHttp(this.client);

  @override
  Future<Product> findProductDetail(String id) async {
    var response = await client
        .get(
          '${AppConstant.productPath}/$id',
          options: Options(headers: {
            Headers.contentTypeHeader: 'application/json; charset=utf-8'
          }),
        )
        .timeout(const Duration(seconds: 15));

    var decoded = jsonDecode(response.data) as Map<String, dynamic>;
    if (decoded['document'] == null) {
      throw 'empty document';
    }

    return Product.fromJson(decoded['document']);
  }
}
