// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      url: json['url'] as String,
      extra: json['extra'],
      labels: (json['labels'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'url': instance.url,
      'extra': instance.extra,
      'labels': instance.labels,
    };
