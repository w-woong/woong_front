import 'package:flutter/material.dart';
// import 'package:woong_front/domains/promotion/promotion.dart';

class Product {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String imgUrl;
  String name;
  double price;
  String description;

  Product({required this.name, required this.price, required this.imgUrl})
      : id = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        description = '';

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt =
            DateTime.parse(json['created_at'] ?? "2006-01-02T01:01:01+09:00"),
        updatedAt =
            DateTime.parse(json['updated_at'] ?? "2006-01-02T01:01:01+09:00"),
        imgUrl = json['img_url'],
        name = json['name'],
        price = json['price'].toDouble(),
        description = json['description'];
}

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

  ProductVM({required this.repo}) : products = [];

  void fetch() async {
    products = await repo.readProducts();
    notifyListeners();
  }
}
