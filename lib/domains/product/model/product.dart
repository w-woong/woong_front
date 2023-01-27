import 'package:json_annotation/json_annotation.dart';
import 'package:woong_front/commons/json.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {
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
  @JsonKey(name: 'img_url')
  String imgUrl;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(
      name: 'price',
      fromJson: JsonUtils.doubleFromJson,
      readValue: JsonUtils.readDouble)
  double price;
  @JsonKey(name: 'description')
  String description;

  @JsonKey(ignore: true)
  List<String> topImgUrlList;

  Product({required this.name, required this.price, required this.imgUrl})
      : id = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        description = '',
        topImgUrlList = [];
  Product.empty()
      : id = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        imgUrl = '',
        name = '',
        price = 0,
        description = '',
        topImgUrlList = [];

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  // Product.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       createdAt =
  //           DateTime.parse(json['created_at'] ?? "2006-01-02T01:01:01+09:00"),
  //       updatedAt =
  //           DateTime.parse(json['updated_at'] ?? "2006-01-02T01:01:01+09:00"),
  //       imgUrl = json['img_url'],
  //       name = json['name'],
  //       price = json['price'].toDouble(),
  //       description = json['description'],
  //       topImgUrlList = json['top_img_url_list'] ?? [];
}
