// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificateResponse _$CertificateResponseFromJson(Map<String, dynamic> json) =>
    CertificateResponse(
      status: json['status'] as bool,
      statusCode: (json['status_code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : CertificateData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CertificateResponseToJson(
  CertificateResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};

CertificateData _$CertificateDataFromJson(Map<String, dynamic> json) =>
    CertificateData(id: (json['id'] as num).toInt());

Map<String, dynamic> _$CertificateDataToJson(CertificateData instance) =>
    <String, dynamic>{'id': instance.id};

CertificateListResponse _$CertificateListResponseFromJson(
  Map<String, dynamic> json,
) => CertificateListResponse(
  status: json['status'] as bool,
  statusCode: (json['status_code'] as num).toInt(),
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => CertificateResponseItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CertificateListResponseToJson(
  CertificateListResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};

CertificateResponseItem _$CertificateResponseItemFromJson(
  Map<String, dynamic> json,
) => CertificateResponseItem(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  certificateDate: json['certificate_date'] as String,
  patientName: json['patient_name'] as String?,
  patientCode: json['patient_code'] as String?,
  doctorName: json['doctor_name'] as String?,
);

Map<String, dynamic> _$CertificateResponseItemToJson(
  CertificateResponseItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'certificate_date': instance.certificateDate,
  'patient_name': instance.patientName,
  'patient_code': instance.patientCode,
  'doctor_name': instance.doctorName,
};
