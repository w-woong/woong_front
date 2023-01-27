// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      id: json['id'] as String,
      createdAt: JsonUtils.dateTimeFromJson(json['created_at'] as String?),
      updatedAt: JsonUtils.dateTimeFromJson(json['updated_at'] as String?),
      name: json['name'] as String,
      description: json['description'] as String,
    )..products = (json['products'] as List<dynamic>?)
        ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': JsonUtils.dateTimeToJson(instance.createdAt),
      'updated_at': JsonUtils.dateTimeToJson(instance.updatedAt),
      'name': instance.name,
      'description': instance.description,
      'products': instance.products?.map((e) => e.toJson()).toList(),
    };
