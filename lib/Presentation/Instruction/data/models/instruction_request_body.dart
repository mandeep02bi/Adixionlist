import 'package:json_annotation/json_annotation.dart';

part 'instruction_request_body.g.dart';

@JsonSerializable()
class InstructionRequestBody {
  @JsonKey(name: 'patient_code')
  final String patientCode;
  final String title;
  final String description;
  @JsonKey(name: 'instruction_date')
  final String instructionDate;

  InstructionRequestBody({
    required this.patientCode,
    required this.title,
    required this.description,
    required this.instructionDate,
  });

  factory InstructionRequestBody.fromJson(Map<String, dynamic> json) =>
      _$InstructionRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$InstructionRequestBodyToJson(this);
}
