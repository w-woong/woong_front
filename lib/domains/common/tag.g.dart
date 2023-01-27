// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      id: json['id'] as String,
      createdAt: JsonUtils.dateTimeFromJson(json['created_at'] as String?),
      updatedAt: JsonUtils.dateTimeFromJson(json['updated_at'] as String?),
      ownerType: json['owner_type'] as String,
      ownerID: json['owner_id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': JsonUtils.dateTimeToJson(instance.createdAt),
      'updated_at': JsonUtils.dateTimeToJson(instance.updatedAt),
      'owner_type': instance.ownerType,
      'owner_id': instance.ownerID,
      'name': instance.name,
    };
