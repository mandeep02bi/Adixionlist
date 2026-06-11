import 'package:json_annotation/json_annotation.dart';

part 'appointment_response.g.dart';

@JsonSerializable()
class AppointmentResponse {
  final bool status;
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String message;
  final AppointmentData? data;

  AppointmentResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentResponseToJson(this);
}

@JsonSerializable()
class AppointmentData {
  final int id;

  AppointmentData({required this.id});

  factory AppointmentData.fromJson(Map<String, dynamic> json) =>
      _$AppointmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentDataToJson(this);
}
