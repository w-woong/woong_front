import 'package:json_annotation/json_annotation.dart';
import 'package:woong_front/commons/json.dart';

part 'tag.g.dart';

@JsonSerializable(explicitToJson: true)
class Tag {
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
  @JsonKey(name: 'owner_type')
  String ownerType;
  @JsonKey(name: 'owner_id')
  String ownerID;
  @JsonKey(name: 'name')
  String name;

  Tag(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.ownerType,
      required this.ownerID,
      required this.name});

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);

  // Tag.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       createdAt =
  //           DateTime.parse(json['created_at'] ?? "2006-01-02T01:01:01+09:00"),
  //       updatedAt =
  //           DateTime.parse(json['updated_at'] ?? "2006-01-02T01:01:01+09:00"),
  //       ownerType = json['owner_type'],
  //       ownerID = json['owner_id'],
  //       name = json['name'];
}
