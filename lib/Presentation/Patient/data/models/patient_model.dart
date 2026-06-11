import 'package:json_annotation/json_annotation.dart';

part 'patient_model.g.dart';

@JsonSerializable()
class PatientModel {
  @JsonKey(name: 'patient_code')
  final String patientCode;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'middle_name')
  final String? middleName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String? phone;
  final String? gender;
  final int? age;
  @JsonKey(name: 'blood_group')
  final String? bloodGroup;
  final String? city;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  PatientModel({
    required this.patientCode,
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.phone,
    this.gender,
    this.age,
    this.bloodGroup,
    this.city,
    this.createdAt,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientModelToJson(this);

  String get fullName {
    if (middleName != null && middleName!.isNotEmpty) {
      return '$firstName $middleName $lastName';
    }
    return '$firstName $lastName';
  }
}
