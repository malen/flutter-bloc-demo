// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartConfig _$StartConfigFromJson(Map<String, dynamic> json) => StartConfig()
  ..network = json['network'] as String
  ..address = json['address'] as String
  ..apiToken = json['apiToken'] as String;

Map<String, dynamic> _$StartConfigToJson(StartConfig instance) =>
    <String, dynamic>{
      'network': instance.network,
      'address': instance.address,
      'apiToken': instance.apiToken,
    };
