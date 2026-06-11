// ─────────────────────────────────────────────────────────────────────────────
// medicine_request_body.dart
// ─────────────────────────────────────────────────────────────────────────────
import 'package:json_annotation/json_annotation.dart';

part 'medicine_request_body.g.dart';

@JsonSerializable()
class MedicineRequestBody {
  final String name;

  @JsonKey(name: 'total_quantity')
  final String? totalQuantity;

  final String? frequency;

  @JsonKey(name: 'route_form')
  final String? routeForm;

  @JsonKey(name: 'no_of_days')
  final String? noOfDays;

  final String? instructions;

  @JsonKey(name: 'additional_comments')
  final String? additionalComments;

  const MedicineRequestBody({
    required this.name,
    this.totalQuantity,
    this.frequency,
    this.routeForm,
    this.noOfDays,
    this.instructions,
    this.additionalComments,
  });

  factory MedicineRequestBody.fromJson(Map<String, dynamic> json) =>
      _$MedicineRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineRequestBodyToJson(this);
}
