import 'package:json_annotation/json_annotation.dart';

part 'certificate_request_body.g.dart';

@JsonSerializable()
class CertificateRequestBody {
  @JsonKey(name: 'patient_code')
  final String patientCode;
  final String title;
  final String description;
  @JsonKey(name: 'certificate_date')
  final String certificateDate;

  CertificateRequestBody({
    required this.patientCode,
    required this.title,
    required this.description,
    required this.certificateDate,
  });

  factory CertificateRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CertificateRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CertificateRequestBodyToJson(this);
}
