import 'package:json_annotation/json_annotation.dart';

part 'reminder_response.g.dart';

@JsonSerializable()
class ReminderResponse {
  final bool status;
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String message;
  final ReminderData? data;

  ReminderResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory ReminderResponse.fromJson(Map<String, dynamic> json) =>
      _$ReminderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReminderResponseToJson(this);
}

@JsonSerializable()
class ReminderData {
  final int id;

  ReminderData({required this.id});

  factory ReminderData.fromJson(Map<String, dynamic> json) =>
      _$ReminderDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReminderDataToJson(this);
}

@JsonSerializable()
class ReminderListResponse {
  final bool status;
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String message;
  final List<ReminderResponseItem>? data;

  ReminderListResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory ReminderListResponse.fromJson(Map<String, dynamic> json) =>
      _$ReminderListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReminderListResponseToJson(this);
}

@JsonSerializable()
class ReminderResponseItem {
  final int id;
  @JsonKey(name: 'reminder_type')
  final String reminderType;
  final String title;
  final String description;
  @JsonKey(name: 'payment_link')
  final String? paymentLink;
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'end_date')
  final String endDate;
  @JsonKey(name: 'is_done')
  final int isDone;
  @JsonKey(name: 'patient_name')
  final String? patientName;
  @JsonKey(name: 'patient_code')
  final String? patientCode;

  ReminderResponseItem({
    required this.id,
    required this.reminderType,
    required this.title,
    required this.description,
    this.paymentLink,
    required this.startDate,
    required this.endDate,
    required this.isDone,
    this.patientName,
    this.patientCode,
  });

  factory ReminderResponseItem.fromJson(Map<String, dynamic> json) =>
      _$ReminderResponseItemFromJson(json);

  Map<String, dynamic> toJson() => _$ReminderResponseItemToJson(this);
}
