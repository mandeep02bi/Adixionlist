// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentResponse _$AppointmentResponseFromJson(Map<String, dynamic> json) =>
    AppointmentResponse(
      status: json['status'] as bool,
      statusCode: (json['status_code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : AppointmentData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppointmentResponseToJson(
  AppointmentResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};

AppointmentData _$AppointmentDataFromJson(Map<String, dynamic> json) =>
    AppointmentData(id: (json['id'] as num).toInt());

Map<String, dynamic> _$AppointmentDataToJson(AppointmentData instance) =>
    <String, dynamic>{'id': instance.id};
