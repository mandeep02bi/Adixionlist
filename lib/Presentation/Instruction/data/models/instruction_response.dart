import 'package:json_annotation/json_annotation.dart';

part 'instruction_response.g.dart';

@JsonSerializable()
class InstructionModel {
  final int id;
  final String ?title;
  final String ?description;
  @JsonKey(name: 'instruction_date')
  final String? instructionDate;
  @JsonKey(name: 'patient_name')
  final String? patientName;
  @JsonKey(name: 'patient_code')
  final String? patientCode;
  @JsonKey(name: 'doctor_name')
  final String? doctorName;

  InstructionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.instructionDate,
    this.patientName,
    this.patientCode,
    this.doctorName,
  });

  factory InstructionModel.fromJson(Map<String, dynamic> json) =>
      _$InstructionModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstructionModelToJson(this);
}

@JsonSerializable()
class InstructionListResponse {
  final bool status;
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String message;
  final List<InstructionModel>? data;

  InstructionListResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory InstructionListResponse.fromJson(Map<String, dynamic> json) =>
      _$InstructionListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InstructionListResponseToJson(this);
}

@JsonSerializable()
class InstructionResponse {
  final bool status;
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String message;
  final InstructionModel? data;

  InstructionResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory InstructionResponse.fromJson(Map<String, dynamic> json) =>
      _$InstructionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InstructionResponseToJson(this);
}
