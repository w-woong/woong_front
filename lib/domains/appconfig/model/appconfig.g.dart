// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appconfig.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => AppConfig(
      name: JsonUtils.stringFromJson(json['name'] as String?),
      id: JsonUtils.stringFromJson(json['id'] as String?),
      createdAt: JsonUtils.dateTimeFromJson(json['created_at'] as String?),
      updatedAt: JsonUtils.dateTimeFromJson(json['updated_at'] as String?),
    );

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': JsonUtils.dateTimeToJson(instance.createdAt),
      'updated_at': JsonUtils.dateTimeToJson(instance.updatedAt),
      'name': instance.name,
    };
