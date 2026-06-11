// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificateRequestBody _$CertificateRequestBodyFromJson(
  Map<String, dynamic> json,
) => CertificateRequestBody(
  patientCode: json['patient_code'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  certificateDate: json['certificate_date'] as String,
);

Map<String, dynamic> _$CertificateRequestBodyToJson(
  CertificateRequestBody instance,
) => <String, dynamic>{
  'patient_code': instance.patientCode,
  'title': instance.title,
  'description': instance.description,
  'certificate_date': instance.certificateDate,
};
