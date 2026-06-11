import 'package:json_annotation/json_annotation.dart';

part 'template_model.g.dart';

@JsonSerializable()
class TemplateModel {
  final int id;
  final String type;
  final String title;
  final String content;

  TemplateModel({
    required this.id,
    required this.type,
    required this.title,
    required this.content,
  });

  factory TemplateModel.fromJson(Map<String, dynamic> json) =>
      _$TemplateModelFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateModelToJson(this);
}
