import 'package:json_annotation/json_annotation.dart';

part 'httpbody.g.dart';

@JsonSerializable(explicitToJson: true)
class HttpBody {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'count')
  int? count;
  @JsonKey(name: 'document')
  dynamic document;
  @JsonKey(name: 'documents')
  List<dynamic>? documents;

  HttpBody();

  factory HttpBody.fromJson(Map<String, dynamic> json) =>
      _$HttpBodyFromJson(json);
  Map<String, dynamic> toJson() => _$HttpBodyToJson(this);
}
