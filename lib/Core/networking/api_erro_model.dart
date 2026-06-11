import 'package:freezed_annotation/freezed_annotation.dart';
part 'api_erro_model.g.dart';

@JsonSerializable()
class ApiErroModel {
  final bool status;
  @JsonKey(name: "status_code")
  final int statusCode;
  final String message;
  final dynamic data;

  ApiErroModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });
  factory ApiErroModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErroModelFromJson(json);
  Map<String, dynamic> toJson() => _$ApiErroModelToJson(this);
}
