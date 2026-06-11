// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instruction_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructionRequestBody _$InstructionRequestBodyFromJson(
  Map<String, dynamic> json,
) => InstructionRequestBody(
  patientCode: json['patient_code'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  instructionDate: json['instruction_date'] as String,
);

Map<String, dynamic> _$InstructionRequestBodyToJson(
  InstructionRequestBody instance,
) => <String, dynamic>{
  'patient_code': instance.patientCode,
  'title': instance.title,
  'description': instance.description,
  'instruction_date': instance.instructionDate,
};
