import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woong_front/commons/strings.dart';
import 'package:woong_front/domains/common/tag.dart';

class Promotion {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String homeID;
  String name;
  String description;
  String imgUrl;
  List<Tag> tags;

  Promotion(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.homeID,
      required this.imgUrl,
      required this.name,
      required this.description,
      required this.tags});

  Promotion.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt =
            DateTime.parse(json['created_at'] ?? "2006-01-02T01:01:01+09:00"),
        updatedAt =
            DateTime.parse(json['updated_at'] ?? "2006-01-02T01:01:01+09:00"),
        homeID = json['home_id'],
        imgUrl = json['img_url'],
        name = json['name'],
        description = json['description'],
        tags = (json['tags'] as List).map((e) => Tag.fromJson(e)).toList();

  String getJoinedTags() {
    return tags.map((e) => e.name).toList().join(' ');
  }
}

class PromotionRepo {
  PromotionRepo();

  final List<String> imgList = [
    // 'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    // 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    // 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  Future<List<Promotion>> getPromotionList() async {
    List<Promotion> list =
        await Future.delayed(const Duration(milliseconds: 500), () {
      List<Promotion> list = [];

      for (String url in imgList) {
        list.add(Promotion(
          id: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          homeID: '',
          imgUrl: url,
          name: StringUtils.randomeString(20),
          description: StringUtils.randomeString(80),
          tags: [],
        ));
      }
      return list;
    });

    return list;
  }
}

class PromotionVM extends ChangeNotifier {
  PromotionRepo repo;
  List<Promotion> promotionList;

  PromotionVM({required this.repo}) : promotionList = [];

  Future<void> fetchPromotionList() async {
    print('fetching promotions');
    promotionList = await repo.getPromotionList();
    notifyListeners();
  }
}
