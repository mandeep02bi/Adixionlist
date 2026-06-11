// ─────────────────────────────────────────────────────────────────────────────
// lab_test_request_body.dart
// ─────────────────────────────────────────────────────────────────────────────
import 'package:json_annotation/json_annotation.dart';

part 'lab_test_request_body.g.dart';

@JsonSerializable()
class LabTestRequestBody {
  @JsonKey(name: 'test_name')
  final String testName;

  @JsonKey(name: 'additional_comments')
  final String? additionalComments;

  const LabTestRequestBody({
    required this.testName,
    this.additionalComments,
  });

  factory LabTestRequestBody.fromJson(Map<String, dynamic> json) =>
      _$LabTestRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LabTestRequestBodyToJson(this);
}
