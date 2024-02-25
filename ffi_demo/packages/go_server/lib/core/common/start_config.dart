import 'package:json_annotation/json_annotation.dart';

part 'start_config.g.dart';

@JsonSerializable()
class StartConfig {
  late String network;
  late String address;
  late String apiToken;

  StartConfig();

  factory StartConfig.fromJson(Map<String, dynamic> json) => _$StartConfigFromJson(json);

  Map<String, dynamic> toJson() => _$StartConfigToJson(this);
}
