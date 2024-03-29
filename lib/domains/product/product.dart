import 'package:flutter/material.dart';
import 'package:woong_front/domains/product/model/product.dart';
// import 'package:woong_front/domains/promotion/promotion.dart';

class ProductRepo {
  ProductRepo();

  Future<List<Product>> readProducts() async {
    List<Product> res =
        await Future.delayed(const Duration(milliseconds: 200), () {
      List<Product> list = [];
      list.add(Product(
          name: 'Product A',
          price: 2000,
          imgUrl:
              'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'));

      list.add(Product(
          name: 'Product B',
          price: 122000,
          imgUrl:
              'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'));

      list.add(Product(
          name: 'Product C',
          price: 2000,
          imgUrl:
              'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'));

      list.add(Product(
          name: 'Product A',
          price: 2000,
          imgUrl:
              'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'));

      list.add(Product(
          name: 'Product B',
          price: 122000,
          imgUrl:
              'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'));

      list.add(Product(
          name: 'Product C',
          price: 2000,
          imgUrl:
              'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'));
      return list;
    });
    return res;
  }
}

class ProductVM extends ChangeNotifier {
  ProductRepo repo;

  List<Product> products;
  Product selectedProduct;

  ProductVM({required this.repo})
      : products = [],
        selectedProduct = Product.empty();

  Future<void> fetch() async {
    products = await repo.readProducts();
    notifyListeners();
  }

  void selectProduct(int index) {
    selectedProduct = products[index];
    notifyListeners();
  }
}
