// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionRequestBody _$PrescriptionRequestBodyFromJson(
  Map<String, dynamic> json,
) => PrescriptionRequestBody(
  patientCode: json['patient_code'] as String,
  appointmentId: (json['appointment_id'] as num?)?.toInt(),
  temperature: json['temperature'] as String?,
  height: json['height'] as String?,
  weight: json['weight'] as String?,
  pulse: json['pulse'] as String?,
  bloodPressure: json['blood_pressure'] as String?,
  bloodSugar: json['blood_sugar'] as String?,
  hemoglobin: json['hemoglobin'] as String?,
  spo2: json['spo2'] as String?,
  respirationRate: json['respiration_rate'] as String?,
  allergy: json['allergy'] as String?,
  chiefComplaint: json['chief_complaint'] as String?,
  history: json['history'] as String?,
  findings: json['findings'] as String?,
  diagnosis: json['diagnosis'] as String?,
  treatmentAdvice: json['treatment_advice'] as String?,
  endNote: json['end_note'] as String?,
  followUpDate: json['follow_up_date'] as String?,
  notes: json['notes'] as String?,
  prescriptionDate: json['prescription_date'] as String?,
);

Map<String, dynamic> _$PrescriptionRequestBodyToJson(
  PrescriptionRequestBody instance,
) => <String, dynamic>{
  'patient_code': instance.patientCode,
  'appointment_id': instance.appointmentId,
  'temperature': instance.temperature,
  'height': instance.height,
  'weight': instance.weight,
  'pulse': instance.pulse,
  'blood_pressure': instance.bloodPressure,
  'blood_sugar': instance.bloodSugar,
  'hemoglobin': instance.hemoglobin,
  'spo2': instance.spo2,
  'respiration_rate': instance.respirationRate,
  'allergy': instance.allergy,
  'chief_complaint': instance.chiefComplaint,
  'history': instance.history,
  'findings': instance.findings,
  'diagnosis': instance.diagnosis,
  'treatment_advice': instance.treatmentAdvice,
  'end_note': instance.endNote,
  'follow_up_date': instance.followUpDate,
  'notes': instance.notes,
  'prescription_date': instance.prescriptionDate,
};
