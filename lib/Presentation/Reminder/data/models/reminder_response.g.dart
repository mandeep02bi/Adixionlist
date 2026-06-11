// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReminderResponse _$ReminderResponseFromJson(Map<String, dynamic> json) =>
    ReminderResponse(
      status: json['status'] as bool,
      statusCode: (json['status_code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : ReminderData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReminderResponseToJson(ReminderResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_code': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

ReminderData _$ReminderDataFromJson(Map<String, dynamic> json) =>
    ReminderData(id: (json['id'] as num).toInt());

Map<String, dynamic> _$ReminderDataToJson(ReminderData instance) =>
    <String, dynamic>{'id': instance.id};

ReminderListResponse _$ReminderListResponseFromJson(
  Map<String, dynamic> json,
) => ReminderListResponse(
  status: json['status'] as bool,
  statusCode: (json['status_code'] as num).toInt(),
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => ReminderResponseItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ReminderListResponseToJson(
  ReminderListResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};

ReminderResponseItem _$ReminderResponseItemFromJson(
  Map<String, dynamic> json,
) => ReminderResponseItem(
  id: (json['id'] as num).toInt(),
  reminderType: json['reminder_type'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  paymentLink: json['payment_link'] as String?,
  startDate: json['start_date'] as String,
  endDate: json['end_date'] as String,
  isDone: (json['is_done'] as num).toInt(),
  patientName: json['patient_name'] as String?,
  patientCode: json['patient_code'] as String?,
);

Map<String, dynamic> _$ReminderResponseItemToJson(
  ReminderResponseItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'reminder_type': instance.reminderType,
  'title': instance.title,
  'description': instance.description,
  'payment_link': instance.paymentLink,
  'start_date': instance.startDate,
  'end_date': instance.endDate,
  'is_done': instance.isDone,
  'patient_name': instance.patientName,
  'patient_code': instance.patientCode,
};
