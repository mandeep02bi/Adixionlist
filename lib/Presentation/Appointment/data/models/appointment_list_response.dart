import 'package:json_annotation/json_annotation.dart';

part 'appointment_list_response.g.dart';

@JsonSerializable()
class AppointmentListResponse {
  final bool status;

  @JsonKey(name: 'status_code')
  final int statusCode;

  final String message;

  final List<AppointmentItem> data;

  AppointmentListResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory AppointmentListResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentListResponseToJson(this);
}

@JsonSerializable()
class AppointmentItem {
  final int id;
  @JsonKey(name: 'patient_name')
  final String? patientName;

  @JsonKey(name: 'patient_code')
  final String? patientCode;

  @JsonKey(name: 'appointment_date')
  final String appointmentDate;

  @JsonKey(name: 'appointment_time')
  final String appointmentTime;

  final String? purpose;

  final String status;

  @JsonKey(name: 'doctor_name')
  final String doctorName;

  @JsonKey(name: 'patient_gender')
  final String? patientGender;

  @JsonKey(name: 'patient_age')
  final int? patientAge;

  @JsonKey(name: 'patient_age_unit')
  final String? patientAgeUnit;

  @JsonKey(name: 'patient_whatsapp')
  final String? patientWhatsapp;

  @JsonKey(name: 'doctor_code')
  final String? doctorCode;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'is_walkin')
  final int? isWalkin;

  AppointmentItem({
    required this.id,
    this.patientName,
    this.patientCode,
    required this.appointmentDate,
    required this.appointmentTime,
    this.purpose,
    required this.status,
    required this.doctorName,
    this.patientGender,
    this.patientAge,
    this.patientAgeUnit,
    this.patientWhatsapp,
    this.doctorCode,
    this.createdAt,
    this.isWalkin,
  });

  factory AppointmentItem.fromJson(Map<String, dynamic> json) =>
      _$AppointmentItemFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentItemToJson(this);
}
