import 'package:json_annotation/json_annotation.dart';

part 'patient_request_body.g.dart';

@JsonSerializable()
class PatientRequestBody {
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'middle_name')
  final String? middleName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String? email;
  final String? phone;
  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;
  final int? age;
  final String? gender;
  @JsonKey(name: 'blood_group')
  final String? bloodGroup;
  @JsonKey(name: 'street_address')
  final String? streetAddress;
  final String? city;
  final String? state;
  @JsonKey(name: 'zip_code')
  final String? zipCode;

  PatientRequestBody({
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.age,
    this.gender,
    this.bloodGroup,
    this.streetAddress,
    this.city,
    this.state,
    this.zipCode,
  });

  factory PatientRequestBody.fromJson(Map<String, dynamic> json) =>
      _$PatientRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PatientRequestBodyToJson(this);
}
