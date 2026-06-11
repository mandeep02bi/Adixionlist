import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patients_list_response.g.dart';

@JsonSerializable()
class PatientsListResponse {
  final bool status;
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String message;
  final List<PatientModel>? data;

  PatientsListResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory PatientsListResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientsListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientsListResponseToJson(this);
}
