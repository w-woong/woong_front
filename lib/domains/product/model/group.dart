import 'package:woong_front/domains/product/model/product.dart';
import 'package:woong_front/domains/product/product.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:woong_front/commons/json.dart';

part 'group.g.dart';

@JsonSerializable(explicitToJson: true)
class Group {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(
      name: 'created_at',
      toJson: JsonUtils.dateTimeToJson,
      fromJson: JsonUtils.dateTimeFromJson)
  DateTime createdAt;
  @JsonKey(
      name: 'updated_at',
      toJson: JsonUtils.dateTimeToJson,
      fromJson: JsonUtils.dateTimeFromJson)
  DateTime updatedAt;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'products')
  List<Product>? products;

  Group(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.name,
      required this.description})
      : products = [];

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  // Group.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       createdAt =
  //           DateTime.parse(json['created_at'] ?? "2006-01-02T01:01:01+09:00"),
  //       updatedAt =
  //           DateTime.parse(json['updated_at'] ?? "2006-01-02T01:01:01+09:00"),
  //       name = json['name'],
  //       description = json['description'],
  //       products = json['products'] == null
  //           ? []
  //           : (json['products'] as List)
  //               .map((e) => Product.fromJson(e))
  //               .toList();
}
