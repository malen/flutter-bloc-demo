// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Resource _$ResourceFromJson(Map<String, dynamic> json) => Resource(
      name: json['name'] as String? ?? "",
      size: json['size'] as int? ?? 0,
      range: json['range'] as bool? ?? false,
      hash: json['hash'] as String? ?? "",
    );

Map<String, dynamic> _$ResourceToJson(Resource instance) => <String, dynamic>{
      'name': instance.name,
      'size': instance.size,
      'range': instance.range,
      'hash': instance.hash,
    };
