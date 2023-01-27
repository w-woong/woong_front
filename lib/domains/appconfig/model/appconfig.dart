import 'package:json_annotation/json_annotation.dart';
import 'package:woong_front/commons/json.dart';

part 'appconfig.g.dart';

@JsonSerializable(explicitToJson: true)
class AppConfig {
  @JsonKey(name: 'id', fromJson: JsonUtils.stringFromJson)
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
  @JsonKey(name: 'name', fromJson: JsonUtils.stringFromJson)
  String name;
  @JsonKey(ignore: true)
  int shoppingNumColumns;

  AppConfig(
      {required this.name,
      required this.id,
      required this.createdAt,
      required this.updatedAt})
      : shoppingNumColumns = 2;

  AppConfig.empty()
      : id = '',
        name = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        shoppingNumColumns = 2;

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AppConfigToJson(this);

  // AppConfig.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       name = json['name'],
  //       createdAt =
  //           DateTime.parse(json['created_at'] ?? "2006-01-02T01:01:01+09:00"),
  //       updatedAt =
  //           DateTime.parse(json['updated_at'] ?? "2006-01-02T01:01:01+09:00"),
  //       shoppingNumColumns = json['shopping_num_columns'] ?? 2;

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'created_at': createdAt,
  //     'updated_at': updatedAt,
  //     'shopping_num_columns': shoppingNumColumns,
  //   };
  // }

  bool isEmpty() {
    if (id == '') {
      return true;
    }
    return false;
  }

  // String get title => _title;

  // set title(String title) {
  //   _title = title;
  // }

}
