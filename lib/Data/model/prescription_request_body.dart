// ─────────────────────────────────────────────────────────────────────────────
// prescription_request_body.dart
// ─────────────────────────────────────────────────────────────────────────────
import 'package:json_annotation/json_annotation.dart';

part 'prescription_request_body.g.dart';

@JsonSerializable()
class PrescriptionRequestBody {
  @JsonKey(name: 'patient_code')
  final String patientCode;

  @JsonKey(name: 'appointment_id')
  final int? appointmentId;

  // Vitals
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

  // Case History
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

  final String? notes;

  @JsonKey(name: 'prescription_date')
  final String? prescriptionDate;

  const PrescriptionRequestBody({
    required this.patientCode,
    this.appointmentId,
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
    this.notes,
    this.prescriptionDate,
  });

  factory PrescriptionRequestBody.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionRequestBodyToJson(this);
}
