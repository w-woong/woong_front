// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'httpbody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpBody _$HttpBodyFromJson(Map<String, dynamic> json) => HttpBody()
  ..status = json['status'] as int?
  ..message = json['message'] as String?
  ..count = json['count'] as int?
  ..document = json['document']
  ..documents = json['documents'] as List<dynamic>?;

Map<String, dynamic> _$HttpBodyToJson(HttpBody instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'count': instance.count,
      'document': instance.document,
      'documents': instance.documents,
    };
