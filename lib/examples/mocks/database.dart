import 'dart:async';

import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class Person {
  final String name;
  int stayedSecond;

  Person({required this.name, required this.stayedSecond});

  Stream<int> get getStayedSecond async* {
    while (stayedSecond < 100) {
      await Future.delayed(Duration(seconds: 1), () => stayedSecond++);
      yield stayedSecond;
    }
  }
}

class Product {
  final String name;

  Product({required this.name});

  Stream<List<Product>> get products async* {
    List<Product> l = [];
    l.add(Product(name: 'a'));
    l.add(Product(name: 'b'));
    yield l;
  }
}
