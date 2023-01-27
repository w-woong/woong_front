import 'package:json_annotation/json_annotation.dart';
import 'package:woong_front/commons/json.dart';

part 'notice.g.dart';

class Notice {
  String title;
  List<String> messages;

  Notice({required this.title, required this.messages});
}

@JsonSerializable(explicitToJson: true)
class ShortNotice {
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
  @JsonKey(name: 'img_url')
  String imgUrl;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'description')
  String description;

  ShortNotice(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.homeID,
      required this.imgUrl,
      required this.name,
      required this.description});

  factory ShortNotice.fromJson(Map<String, dynamic> json) =>
      _$ShortNoticeFromJson(json);

  Map<String, dynamic> toJson() => _$ShortNoticeToJson(this);

  // ShortNotice.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       homeID = json['home_id'],
  //       createdAt =
  //           DateTime.parse(json['created_at'] ?? "2006-01-02T01:01:01+09:00"),
  //       updatedAt =
  //           DateTime.parse(json['updated_at'] ?? "2006-01-02T01:01:01+09:00"),
  //       imgUrl = json['img_url'],
  //       name = json['name'],
  //       description = json['description'];

  // ShortNotice.fromJsonList(List<Map<String, dynamic>> json) {
  //   List<ShortNotice> list = [];
  //   for (var i = 0; i < json.length; i++) {

  //   }
  // }
}
