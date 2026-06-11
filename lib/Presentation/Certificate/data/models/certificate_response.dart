import 'package:json_annotation/json_annotation.dart';

part 'certificate_response.g.dart';

@JsonSerializable()
class CertificateResponse {
  final bool status;
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String message;
  final CertificateData? data;

  CertificateResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory CertificateResponse.fromJson(Map<String, dynamic> json) =>
      _$CertificateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CertificateResponseToJson(this);
}

@JsonSerializable()
class CertificateData {
  final int id;

  CertificateData({required this.id});

  factory CertificateData.fromJson(Map<String, dynamic> json) =>
      _$CertificateDataFromJson(json);

  Map<String, dynamic> toJson() => _$CertificateDataToJson(this);
}

@JsonSerializable()
class CertificateListResponse {
  final bool status;
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String message;
  final List<CertificateResponseItem>? data;

  CertificateListResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory CertificateListResponse.fromJson(Map<String, dynamic> json) =>
      _$CertificateListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CertificateListResponseToJson(this);
}

@JsonSerializable()
class CertificateResponseItem {
  final int id;
  final String title;
  final String description;
  @JsonKey(name: 'certificate_date')
  final String certificateDate;
  @JsonKey(name: 'patient_name')
  final String? patientName;
  @JsonKey(name: 'patient_code')
  final String? patientCode;
  @JsonKey(name: 'doctor_name')
  final String? doctorName;

  CertificateResponseItem({
    required this.id,
    required this.title,
    required this.description,
    required this.certificateDate,
    this.patientName,
    this.patientCode,
    this.doctorName,
  });

  factory CertificateResponseItem.fromJson(Map<String, dynamic> json) =>
      _$CertificateResponseItemFromJson(json);

  Map<String, dynamic> toJson() => _$CertificateResponseItemToJson(this);
}
