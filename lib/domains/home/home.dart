import 'package:flutter/material.dart';
import 'package:woong_front/domains/appconfig/appconfig.dart';
import 'package:woong_front/domains/notice/notice.dart';
import 'package:woong_front/domains/product/group.dart';
import 'package:woong_front/domains/product/product.dart';
import 'package:woong_front/domains/promotion/promotion.dart';

class Home {
  String id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  String appConfigID;
  AppConfig appConfig;

  List<ShortNotice> shortNoticeList;
  List<Promotion> mainPromotionList;
  List<Group> mainProducts;

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

  Home.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        createdAt =
            DateTime.parse(json['created_at'] ?? "2006-01-02T01:01:01+09:00"),
        updatedAt =
            DateTime.parse(json['updated_at'] ?? "2006-01-02T01:01:01+09:00"),
        appConfigID = json['app_config_id'],
        appConfig = AppConfig.fromJson(json['app_config']),
        shortNoticeList = (json['short_notice_list'] as List)
            .map((e) => ShortNotice.fromJson(e))
            .toList(),
        mainPromotionList = (json['main_promotion_list'] as List)
            .map((e) => Promotion.fromJson(e))
            .toList(),
        mainProducts = (json['main_products'] as List)
            .map((e) => Group.fromJson(e))
            .toList();
}
