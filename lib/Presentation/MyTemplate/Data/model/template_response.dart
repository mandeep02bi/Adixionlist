import 'package:json_annotation/json_annotation.dart';
import 'template_model.dart';

part 'template_response.g.dart';

@JsonSerializable()
class TemplateResponse {
  final bool? status;
  final int? statusCode;
  final String? message;
  final List<TemplateModel>? data;

  TemplateResponse({this.status, this.statusCode, this.message, this.data});

  factory TemplateResponse.fromJson(Map<String, dynamic> json) =>
      _$TemplateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateResponseToJson(this);
}
