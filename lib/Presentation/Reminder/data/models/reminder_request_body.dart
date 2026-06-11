import 'package:json_annotation/json_annotation.dart';

part 'reminder_request_body.g.dart';

@JsonSerializable()
class ReminderRequestBody {
  @JsonKey(name: 'patient_code')
  final String patientCode;
  @JsonKey(name: 'reminder_type')
  final String reminderType; // "Reminder" or "Payment Reminder"
  final String title;
  final String description;
  @JsonKey(name: 'payment_link')
  final String? paymentLink;
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'end_date')
  final String endDate;

  ReminderRequestBody({
    required this.patientCode,
    required this.reminderType,
    required this.title,
    required this.description,
    this.paymentLink,
    required this.startDate,
    required this.endDate,
  });

  factory ReminderRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ReminderRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ReminderRequestBodyToJson(this);
}
