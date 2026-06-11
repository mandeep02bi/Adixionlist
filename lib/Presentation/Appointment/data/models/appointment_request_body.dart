import 'package:json_annotation/json_annotation.dart';

part 'appointment_request_body.g.dart';

@JsonSerializable()
class AppointmentRequestBody {
  @JsonKey(name: 'patient_code')
  final String patientCode;
  @JsonKey(name: 'doctor_code')
  final String doctorCode;
  @JsonKey(name: 'appointment_date')
  final String appointmentDate;
  @JsonKey(name: 'appointment_time')
  final String appointmentTime;
  final String? purpose;
  final String? notes;

  AppointmentRequestBody({
    required this.patientCode,
    required this.doctorCode,
    required this.appointmentDate,
    required this.appointmentTime,
    this.purpose,
    this.notes,
  });

  factory AppointmentRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AppointmentRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentRequestBodyToJson(this);
}
