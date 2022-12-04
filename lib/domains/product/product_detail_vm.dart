import 'package:flutter/material.dart';
import 'package:woong_front/domains/product/product.dart';
import 'package:woong_front/domains/product/product_detail_repo.dart';

class ProductDetailVM extends ChangeNotifier {
  ProductDetailRepo repo;
  Product product;

  ProductDetailVM({required this.repo, required this.product});

  void fetch(String id) async {
    product = await repo.findProductDetail(id);
    notifyListeners();
  }
}
