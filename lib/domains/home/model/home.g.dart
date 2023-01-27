// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Home _$HomeFromJson(Map<String, dynamic> json) => Home(
      name: json['name'] as String,
      id: json['id'] as String,
      createdAt: JsonUtils.dateTimeFromJson(json['created_at'] as String?),
      updatedAt: JsonUtils.dateTimeFromJson(json['updated_at'] as String?),
      appConfigID: json['app_config_id'] as String,
      appConfig: AppConfig.fromJson(json['app_config'] as Map<String, dynamic>),
    )
      ..shortNoticeList = (json['short_notice_list'] as List<dynamic>?)
          ?.map((e) => ShortNotice.fromJson(e as Map<String, dynamic>))
          .toList()
      ..mainPromotionList = (json['main_promotion_list'] as List<dynamic>?)
          ?.map((e) => Promotion.fromJson(e as Map<String, dynamic>))
          .toList()
      ..mainProducts = (json['main_products'] as List<dynamic>?)
          ?.map((e) => Group.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$HomeToJson(Home instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': JsonUtils.dateTimeToJson(instance.createdAt),
      'updated_at': JsonUtils.dateTimeToJson(instance.updatedAt),
      'app_config_id': instance.appConfigID,
      'app_config': instance.appConfig.toJson(),
      'short_notice_list':
          instance.shortNoticeList?.map((e) => e.toJson()).toList(),
      'main_promotion_list':
          instance.mainPromotionList?.map((e) => e.toJson()).toList(),
      'main_products': instance.mainProducts?.map((e) => e.toJson()).toList(),
    };
