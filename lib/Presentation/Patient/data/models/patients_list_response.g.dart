// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patients_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientsListResponse _$PatientsListResponseFromJson(
  Map<String, dynamic> json,
) => PatientsListResponse(
  status: json['status'] as bool,
  statusCode: (json['status_code'] as num).toInt(),
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => PatientModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PatientsListResponseToJson(
  PatientsListResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};
