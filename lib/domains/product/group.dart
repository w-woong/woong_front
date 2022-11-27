import 'package:woong_front/domains/product/product.dart';

class Group {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String description;
  List<Product> products;

  Group(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.name,
      required this.description})
      : products = [];

  Group.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt =
            DateTime.parse(json['created_at'] ?? "2006-01-02T01:01:01+09:00"),
        updatedAt =
            DateTime.parse(json['updated_at'] ?? "2006-01-02T01:01:01+09:00"),
        name = json['name'],
        description = json['description'],
        products = json['products'] == null
            ? []
            : (json['products'] as List)
                .map((e) => Product.fromJson(e))
                .toList();
}
