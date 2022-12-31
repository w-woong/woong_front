// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartProduct _$CartProductFromJson(Map<String, dynamic> json) => CartProduct(
      id: JsonUtils.stringFromJson(json['id'] as String?),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      cartID: JsonUtils.stringFromJson(json['cart_id'] as String?),
      productID: JsonUtils.stringFromJson(json['product_id'] as String?),
      cost: JsonUtils.doubleFromJson(
          JsonUtils.readDouble(json, 'cost') as double?),
      qty: JsonUtils.doubleFromJson(
          JsonUtils.readDouble(json, 'qty') as double?),
      amt: JsonUtils.doubleFromJson(
          JsonUtils.readDouble(json, 'amt') as double?),
      selected: JsonUtils.boolFromJson(json['selected'] as bool?),
    )..productImgUrl =
        JsonUtils.stringFromJson(json['product_img_url'] as String?);

Map<String, dynamic> _$CartProductToJson(CartProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': JsonUtils.dateTimeToJson(instance.createdAt),
      'updated_at': JsonUtils.dateTimeToJson(instance.updatedAt),
      'cart_id': instance.cartID,
      'product_id': instance.productID,
      'product_img_url': instance.productImgUrl,
      'cost': instance.cost,
      'qty': instance.qty,
      'amt': instance.amt,
      'selected': instance.selected,
    };
