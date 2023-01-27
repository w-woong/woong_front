// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String,
      price: JsonUtils.doubleFromJson(
          JsonUtils.readDouble(json, 'price') as double?),
      imgUrl: json['img_url'] as String,
    )
      ..id = json['id'] as String
      ..createdAt = JsonUtils.dateTimeFromJson(json['created_at'] as String?)
      ..updatedAt = JsonUtils.dateTimeFromJson(json['updated_at'] as String?)
      ..description = json['description'] as String;

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': JsonUtils.dateTimeToJson(instance.createdAt),
      'updated_at': JsonUtils.dateTimeToJson(instance.updatedAt),
      'img_url': instance.imgUrl,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
    };
