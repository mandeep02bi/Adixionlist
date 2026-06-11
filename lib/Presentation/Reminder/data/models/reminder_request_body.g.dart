// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReminderRequestBody _$ReminderRequestBodyFromJson(Map<String, dynamic> json) =>
    ReminderRequestBody(
      patientCode: json['patient_code'] as String,
      reminderType: json['reminder_type'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      paymentLink: json['payment_link'] as String?,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
    );

Map<String, dynamic> _$ReminderRequestBodyToJson(
  ReminderRequestBody instance,
) => <String, dynamic>{
  'patient_code': instance.patientCode,
  'reminder_type': instance.reminderType,
  'title': instance.title,
  'description': instance.description,
  'payment_link': instance.paymentLink,
  'start_date': instance.startDate,
  'end_date': instance.endDate,
};
