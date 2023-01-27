import 'package:flutter/material.dart';
import 'package:woong_front/commons/json.dart';
import 'package:woong_front/domains/appconfig/appconfig.dart';
import 'package:woong_front/domains/notice/model/notice.dart';
import 'package:woong_front/domains/product/model/group.dart';
import 'package:woong_front/domains/product/product.dart';
import 'package:woong_front/domains/promotion/model/promotion.dart';
import 'package:woong_front/domains/promotion/promotion.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home.g.dart';

@JsonSerializable(explicitToJson: true)
class Home {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'name')
  String name;
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

  @JsonKey(name: 'app_config_id')
  String appConfigID;
  @JsonKey(name: 'app_config')
  AppConfig appConfig;

  @JsonKey(name: 'short_notice_list')
  List<ShortNotice>? shortNoticeList;
  @JsonKey(name: 'main_promotion_list')
  List<Promotion>? mainPromotionList;
  @JsonKey(name: 'main_products')
  List<Group>? mainProducts;

  Home(
      {required this.name,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.appConfigID,
      required this.appConfig})
      : shortNoticeList = [],
        mainPromotionList = [],
        mainProducts = [];
  Home.empty()
      : id = '',
        name = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        appConfigID = '',
        appConfig = AppConfig.empty(),
        shortNoticeList = [],
        mainPromotionList = [],
        mainProducts = [];

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);

  Map<String, dynamic> toJson() => _$HomeToJson(this);

  // Home.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       name = json['name'],
  //       createdAt =
  //           DateTime.parse(json['created_at'] ?? "2006-01-02T01:01:01+09:00"),
  //       updatedAt =
  //           DateTime.parse(json['updated_at'] ?? "2006-01-02T01:01:01+09:00"),
  //       appConfigID = json['app_config_id'],
  //       appConfig = AppConfig.fromJson(json['app_config']),
  //       shortNoticeList = (json['short_notice_list'] as List)
  //           .map((e) => ShortNotice.fromJson(e))
  //           .toList(),
  //       mainPromotionList = (json['main_promotion_list'] as List)
  //           .map((e) => Promotion.fromJson(e))
  //           .toList(),
  //       mainProducts = (json['main_products'] as List)
  //           .map((e) => Group.fromJson(e))
  //           .toList();
}
