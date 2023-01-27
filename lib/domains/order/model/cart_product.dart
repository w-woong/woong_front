import 'package:json_annotation/json_annotation.dart';
import 'package:woong_front/commons/json.dart';
import 'package:woong_front/domains/common/httpbody.dart';
import 'package:woong_front/domains/product/model/product.dart';
import 'package:woong_front/domains/product/product.dart';

part 'cart_product.g.dart';

@JsonSerializable(explicitToJson: true)
class CartProduct {
  @JsonKey(name: 'id', fromJson: JsonUtils.stringFromJson)
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

  @JsonKey(name: 'cart_id', fromJson: JsonUtils.stringFromJson)
  String cartID;

  @JsonKey(name: 'product_id', fromJson: JsonUtils.stringFromJson)
  String productID;

  @JsonKey(name: 'product_img_url', fromJson: JsonUtils.stringFromJson)
  String? productImgUrl;

  @JsonKey(
      name: 'cost',
      fromJson: JsonUtils.doubleFromJson,
      readValue: JsonUtils.readDouble)
  double cost;

  @JsonKey(
      name: 'qty',
      fromJson: JsonUtils.doubleFromJson,
      readValue: JsonUtils.readDouble)
  double qty;

  @JsonKey(
      name: 'amt',
      fromJson: JsonUtils.doubleFromJson,
      readValue: JsonUtils.readDouble)
  double amt;

  @JsonKey(name: 'selected', fromJson: JsonUtils.boolFromJson)
  bool selected;

  CartProduct({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.cartID,
    required this.productID,
    required this.cost,
    required this.qty,
    required this.amt,
    required this.selected,
  });

  CartProduct.empty()
      : id = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        cartID = '',
        productID = '',
        cost = 0.0,
        qty = 0.0,
        amt = 0.0,
        selected = false;

  CartProduct.withProduct(this.cartID, Product product, this.qty, this.amt)
      : id = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        productID = product.id,
        cost = product.price,
        selected = true;

  factory CartProduct.fromJson(Map<String, dynamic> json) =>
      _$CartProductFromJson(json);

  Map<String, dynamic> toJson() => _$CartProductToJson(this);
}
