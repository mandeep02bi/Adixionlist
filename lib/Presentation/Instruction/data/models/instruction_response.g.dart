// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instruction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructionModel _$InstructionModelFromJson(Map<String, dynamic> json) =>
    InstructionModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      instructionDate: json['instruction_date'] as String?,
      patientName: json['patient_name'] as String?,
      patientCode: json['patient_code'] as String?,
      doctorName: json['doctor_name'] as String?,
    );

Map<String, dynamic> _$InstructionModelToJson(InstructionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'instruction_date': instance.instructionDate,
      'patient_name': instance.patientName,
      'patient_code': instance.patientCode,
      'doctor_name': instance.doctorName,
    };

InstructionListResponse _$InstructionListResponseFromJson(
  Map<String, dynamic> json,
) => InstructionListResponse(
  status: json['status'] as bool,
  statusCode: (json['status_code'] as num).toInt(),
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => InstructionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$InstructionListResponseToJson(
  InstructionListResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};

InstructionResponse _$InstructionResponseFromJson(Map<String, dynamic> json) =>
    InstructionResponse(
      status: json['status'] as bool,
      statusCode: (json['status_code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : InstructionModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InstructionResponseToJson(
  InstructionResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};
