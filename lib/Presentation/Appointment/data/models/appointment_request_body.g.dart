// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentRequestBody _$AppointmentRequestBodyFromJson(
  Map<String, dynamic> json,
) => AppointmentRequestBody(
  patientCode: json['patient_code'] as String,
  doctorCode: json['doctor_code'] as String,
  appointmentDate: json['appointment_date'] as String,
  appointmentTime: json['appointment_time'] as String,
  purpose: json['purpose'] as String?,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$AppointmentRequestBodyToJson(
  AppointmentRequestBody instance,
) => <String, dynamic>{
  'patient_code': instance.patientCode,
  'doctor_code': instance.doctorCode,
  'appointment_date': instance.appointmentDate,
  'appointment_time': instance.appointmentTime,
  'purpose': instance.purpose,
  'notes': instance.notes,
};
