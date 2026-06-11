// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientRequestBody _$PatientRequestBodyFromJson(Map<String, dynamic> json) =>
    PatientRequestBody(
      firstName: json['first_name'] as String,
      middleName: json['middle_name'] as String?,
      lastName: json['last_name'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      age: (json['age'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      bloodGroup: json['blood_group'] as String?,
      streetAddress: json['street_address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zip_code'] as String?,
    );

Map<String, dynamic> _$PatientRequestBodyToJson(PatientRequestBody instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'middle_name': instance.middleName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'date_of_birth': instance.dateOfBirth,
      'age': instance.age,
      'gender': instance.gender,
      'blood_group': instance.bloodGroup,
      'street_address': instance.streetAddress,
      'city': instance.city,
      'state': instance.state,
      'zip_code': instance.zipCode,
    };
