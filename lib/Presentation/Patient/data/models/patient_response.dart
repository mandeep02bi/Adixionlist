import 'package:json_annotation/json_annotation.dart';

part 'patient_response.g.dart';

@JsonSerializable()
class PatientResponse {
  final bool status;
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String message;
  final PatientData? data;

  PatientResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory PatientResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientResponseToJson(this);
}

@JsonSerializable()
class PatientData {
  @JsonKey(name: 'patient_code')
  final String patientCode;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'middle_name')
  final String? middleName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String? phone;

  PatientData({
    required this.patientCode,
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.phone,
  });

  factory PatientData.fromJson(Map<String, dynamic> json) =>
      _$PatientDataFromJson(json);

  Map<String, dynamic> toJson() => _$PatientDataToJson(this);
}
