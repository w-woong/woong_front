// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promotion _$PromotionFromJson(Map<String, dynamic> json) => Promotion(
      id: json['id'] as String,
      createdAt: JsonUtils.dateTimeFromJson(json['created_at'] as String?),
      updatedAt: JsonUtils.dateTimeFromJson(json['updated_at'] as String?),
      homeID: json['home_id'] as String,
      imgUrl: json['img_url'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': JsonUtils.dateTimeToJson(instance.createdAt),
      'updated_at': JsonUtils.dateTimeToJson(instance.updatedAt),
      'home_id': instance.homeID,
      'name': instance.name,
      'description': instance.description,
      'img_url': instance.imgUrl,
      'tags': instance.tags?.map((e) => e.toJson()).toList(),
    };
