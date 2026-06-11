// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientModel _$PatientModelFromJson(Map<String, dynamic> json) => PatientModel(
  patientCode: json['patient_code'] as String,
  firstName: json['first_name'] as String,
  middleName: json['middle_name'] as String?,
  lastName: json['last_name'] as String,
  phone: json['phone'] as String?,
  gender: json['gender'] as String?,
  age: (json['age'] as num?)?.toInt(),
  bloodGroup: json['blood_group'] as String?,
  city: json['city'] as String?,
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$PatientModelToJson(PatientModel instance) =>
    <String, dynamic>{
      'patient_code': instance.patientCode,
      'first_name': instance.firstName,
      'middle_name': instance.middleName,
      'last_name': instance.lastName,
      'phone': instance.phone,
      'gender': instance.gender,
      'age': instance.age,
      'blood_group': instance.bloodGroup,
      'city': instance.city,
      'created_at': instance.createdAt,
    };
