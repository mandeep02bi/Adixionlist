// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientResponse _$PatientResponseFromJson(Map<String, dynamic> json) =>
    PatientResponse(
      status: json['status'] as bool,
      statusCode: (json['status_code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : PatientData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatientResponseToJson(PatientResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_code': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

PatientData _$PatientDataFromJson(Map<String, dynamic> json) => PatientData(
  patientCode: json['patient_code'] as String,
  firstName: json['first_name'] as String,
  middleName: json['middle_name'] as String?,
  lastName: json['last_name'] as String,
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$PatientDataToJson(PatientData instance) =>
    <String, dynamic>{
      'patient_code': instance.patientCode,
      'first_name': instance.firstName,
      'middle_name': instance.middleName,
      'last_name': instance.lastName,
      'phone': instance.phone,
    };
