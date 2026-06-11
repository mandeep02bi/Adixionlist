// ─────────────────────────────────────────────────────────────────────────────
// prescription_response.dart
// ─────────────────────────────────────────────────────────────────────────────
import 'package:json_annotation/json_annotation.dart';

part 'prescription_response.g.dart';

// ── Shared base ───────────────────────────────────────────────────────────────

@JsonSerializable(genericArgumentFactories: false)
class BaseApiResponse {
  final bool status;

  @JsonKey(name: 'status_code')
  final int statusCode;

  final String message;
  final dynamic data;

  const BaseApiResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory BaseApiResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseApiResponseToJson(this);
}

// ── Create Prescription ────────────────────────────────────────────────────────

@JsonSerializable()
class CreatePrescriptionData {
  final int id;
  const CreatePrescriptionData({required this.id});
  factory CreatePrescriptionData.fromJson(Map<String, dynamic> json) =>
      _$CreatePrescriptionDataFromJson(json);
  Map<String, dynamic> toJson() => _$CreatePrescriptionDataToJson(this);
}

@JsonSerializable()
class CreatePrescriptionResponse {
  final bool status;

  @JsonKey(name: 'status_code')
  final int statusCode;

  final String message;
  final CreatePrescriptionData? data;

  const CreatePrescriptionResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory CreatePrescriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatePrescriptionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePrescriptionResponseToJson(this);
}

// ── List Prescriptions ─────────────────────────────────────────────────────────

@JsonSerializable()
class PrescriptionListItem {
  final int id;
  final String? diagnosis;

  @JsonKey(name: 'chief_complaint')
  final String? chiefComplaint;

  @JsonKey(name: 'prescription_date')
  final String? prescriptionDate;

  @JsonKey(name: 'follow_up_date')
  final String? followUpDate;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'doctor_name')
  final String? doctorName;

  @JsonKey(name: 'patient_name')
  final String? patientName;

  @JsonKey(name: 'patient_code')
  final String? patientCode;

  const PrescriptionListItem({
    required this.id,
    this.diagnosis,
    this.chiefComplaint,
    this.prescriptionDate,
    this.followUpDate,
    this.createdAt,
    this.doctorName,
    this.patientName,
    this.patientCode,
  });

  factory PrescriptionListItem.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionListItemFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionListItemToJson(this);
}

@JsonSerializable()
class PrescriptionsListResponse {
  final bool status;

  @JsonKey(name: 'status_code')
  final int statusCode;

  final String message;
  final List<PrescriptionListItem>? data;

  const PrescriptionsListResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory PrescriptionsListResponse.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionsListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionsListResponseToJson(this);
}

// ── Prescription Detail ────────────────────────────────────────────────────────

@JsonSerializable()
class MedicineItem {
  final int id;
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

  const MedicineItem({
    required this.id,
    required this.name,
    this.totalQuantity,
    this.frequency,
    this.routeForm,
    this.noOfDays,
    this.instructions,
    this.additionalComments,
  });

  factory MedicineItem.fromJson(Map<String, dynamic> json) =>
      _$MedicineItemFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineItemToJson(this);
}

@JsonSerializable()
class LabTestItem {
  final int id;

  @JsonKey(name: 'test_name')
  final String testName;

  @JsonKey(name: 'additional_comments')
  final String? additionalComments;

  const LabTestItem({
    required this.id,
    required this.testName,
    this.additionalComments,
  });

  factory LabTestItem.fromJson(Map<String, dynamic> json) =>
      _$LabTestItemFromJson(json);

  Map<String, dynamic> toJson() => _$LabTestItemToJson(this);
}

@JsonSerializable()
class PrescriptionDetail {
  final int id;
  final String? temperature;
  final String? height;
  final String? weight;
  final String? pulse;

  @JsonKey(name: 'blood_pressure')
  final String? bloodPressure;

  @JsonKey(name: 'blood_sugar')
  final String? bloodSugar;

  final String? hemoglobin;
  final String? spo2;

  @JsonKey(name: 'respiration_rate')
  final String? respirationRate;

  final String? allergy;

  @JsonKey(name: 'chief_complaint')
  final String? chiefComplaint;

  final String? history;
  final String? findings;
  final String? diagnosis;

  @JsonKey(name: 'treatment_advice')
  final String? treatmentAdvice;

  @JsonKey(name: 'end_note')
  final String? endNote;

  @JsonKey(name: 'follow_up_date')
  final String? followUpDate;

  @JsonKey(name: 'prescription_date')
  final String? prescriptionDate;

  @JsonKey(name: 'doctor_name')
  final String? doctorName;

  @JsonKey(name: 'patient_name')
  final String? patientName;

  @JsonKey(name: 'patient_code')
  final String? patientCode;

  final String? gender;
  final int? age;

  @JsonKey(name: 'patient_phone')
  final String? patientPhone;

  final String? city;
  final List<MedicineItem>? medicines;

  @JsonKey(name: 'lab_tests')
  final List<LabTestItem>? labTests;

  const PrescriptionDetail({
    required this.id,
    this.temperature,
    this.height,
    this.weight,
    this.pulse,
    this.bloodPressure,
    this.bloodSugar,
    this.hemoglobin,
    this.spo2,
    this.respirationRate,
    this.allergy,
    this.chiefComplaint,
    this.history,
    this.findings,
    this.diagnosis,
    this.treatmentAdvice,
    this.endNote,
    this.followUpDate,
    this.prescriptionDate,
    this.doctorName,
    this.patientName,
    this.patientCode,
    this.gender,
    this.age,
    this.patientPhone,
    this.city,
    this.medicines,
    this.labTests,
  });

  factory PrescriptionDetail.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionDetailToJson(this);
}

@JsonSerializable()
class PrescriptionDetailResponse {
  final bool status;

  @JsonKey(name: 'status_code')
  final int statusCode;

  final String message;
  final PrescriptionDetail? data;

  const PrescriptionDetailResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory PrescriptionDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionDetailResponseToJson(this);
}

// ── Medicine Response ──────────────────────────────────────────────────────────

@JsonSerializable()
class CreateMedicineResponse {
  final bool status;

  @JsonKey(name: 'status_code')
  final int statusCode;

  final String message;
  final CreatePrescriptionData? data;

  const CreateMedicineResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory CreateMedicineResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateMedicineResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateMedicineResponseToJson(this);
}

// ── LabTest Response ───────────────────────────────────────────────────────────

@JsonSerializable()
class CreateLabTestResponse {
  final bool status;

  @JsonKey(name: 'status_code')
  final int statusCode;

  final String message;
  final CreatePrescriptionData? data;

  const CreateLabTestResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory CreateLabTestResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateLabTestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateLabTestResponseToJson(this);
}
