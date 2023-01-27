// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortNotice _$ShortNoticeFromJson(Map<String, dynamic> json) => ShortNotice(
      id: json['id'] as String,
      createdAt: JsonUtils.dateTimeFromJson(json['created_at'] as String?),
      updatedAt: JsonUtils.dateTimeFromJson(json['updated_at'] as String?),
      homeID: json['home_id'] as String,
      imgUrl: json['img_url'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$ShortNoticeToJson(ShortNotice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': JsonUtils.dateTimeToJson(instance.createdAt),
      'updated_at': JsonUtils.dateTimeToJson(instance.updatedAt),
      'home_id': instance.homeID,
      'img_url': instance.imgUrl,
      'name': instance.name,
      'description': instance.description,
    };
