// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      userID: JsonUtils.stringFromJson(json['user_id'] as String?),
      cartProducts: (json['cart_products'] as List<dynamic>?)
          ?.map((e) => CartProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': JsonUtils.dateTimeToJson(instance.createdAt),
      'updated_at': JsonUtils.dateTimeToJson(instance.updatedAt),
      'user_id': instance.userID,
      'cart_products': instance.cartProducts?.map((e) => e.toJson()).toList(),
    };
