// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentListResponse _$AppointmentListResponseFromJson(
  Map<String, dynamic> json,
) => AppointmentListResponse(
  status: json['status'] as bool,
  statusCode: (json['status_code'] as num).toInt(),
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => AppointmentItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AppointmentListResponseToJson(
  AppointmentListResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};

AppointmentItem _$AppointmentItemFromJson(Map<String, dynamic> json) =>
    AppointmentItem(
      id: (json['id'] as num).toInt(),
      patientName: json['patient_name'] as String?,
      patientCode: json['patient_code'] as String?,
      appointmentDate: json['appointment_date'] as String,
      appointmentTime: json['appointment_time'] as String,
      purpose: json['purpose'] as String?,
      status: json['status'] as String,
      doctorName: json['doctor_name'] as String,
      patientGender: json['patient_gender'] as String?,
      patientAge: (json['patient_age'] as num?)?.toInt(),
      patientAgeUnit: json['patient_age_unit'] as String?,
      patientWhatsapp: json['patient_whatsapp'] as String?,
      doctorCode: json['doctor_code'] as String?,
      createdAt: json['created_at'] as String?,
      isWalkin: (json['is_walkin'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AppointmentItemToJson(AppointmentItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient_name': instance.patientName,
      'patient_code': instance.patientCode,
      'appointment_date': instance.appointmentDate,
      'appointment_time': instance.appointmentTime,
      'purpose': instance.purpose,
      'status': instance.status,
      'doctor_name': instance.doctorName,
      'patient_gender': instance.patientGender,
      'patient_age': instance.patientAge,
      'patient_age_unit': instance.patientAgeUnit,
      'patient_whatsapp': instance.patientWhatsapp,
      'doctor_code': instance.doctorCode,
      'created_at': instance.createdAt,
      'is_walkin': instance.isWalkin,
    };
