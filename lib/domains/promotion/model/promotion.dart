import 'package:json_annotation/json_annotation.dart';
import 'package:woong_front/commons/json.dart';
import 'package:woong_front/domains/common/tag.dart';

part 'promotion.g.dart';

@JsonSerializable(explicitToJson: true)
class Promotion {
  @JsonKey(name: 'id')
  String id;
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
  @JsonKey(name: 'home_id')
  String homeID;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'img_url')
  String imgUrl;
  @JsonKey(name: 'tags')
  List<Tag>? tags;

  Promotion(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.homeID,
      required this.imgUrl,
      required this.name,
      required this.description,
      required this.tags});

  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionToJson(this);

  // Promotion.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       createdAt =
  //           DateTime.parse(json['created_at'] ?? "2006-01-02T01:01:01+09:00"),
  //       updatedAt =
  //           DateTime.parse(json['updated_at'] ?? "2006-01-02T01:01:01+09:00"),
  //       homeID = json['home_id'],
  //       imgUrl = json['img_url'],
  //       name = json['name'],
  //       description = json['description'],
  //       tags = (json['tags'] as List).map((e) => Tag.fromJson(e)).toList();

  String getJoinedTags() {
    return tags!.map((e) => e.name).toList().join(' ');
  }
}
