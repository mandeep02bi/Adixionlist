// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseApiResponse _$BaseApiResponseFromJson(Map<String, dynamic> json) =>
    BaseApiResponse(
      status: json['status'] as bool,
      statusCode: (json['status_code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'],
    );

Map<String, dynamic> _$BaseApiResponseToJson(BaseApiResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_code': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

CreatePrescriptionData _$CreatePrescriptionDataFromJson(
  Map<String, dynamic> json,
) => CreatePrescriptionData(id: (json['id'] as num).toInt());

Map<String, dynamic> _$CreatePrescriptionDataToJson(
  CreatePrescriptionData instance,
) => <String, dynamic>{'id': instance.id};

CreatePrescriptionResponse _$CreatePrescriptionResponseFromJson(
  Map<String, dynamic> json,
) => CreatePrescriptionResponse(
  status: json['status'] as bool,
  statusCode: (json['status_code'] as num).toInt(),
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : CreatePrescriptionData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreatePrescriptionResponseToJson(
  CreatePrescriptionResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};

PrescriptionListItem _$PrescriptionListItemFromJson(
  Map<String, dynamic> json,
) => PrescriptionListItem(
  id: (json['id'] as num).toInt(),
  diagnosis: json['diagnosis'] as String?,
  chiefComplaint: json['chief_complaint'] as String?,
  prescriptionDate: json['prescription_date'] as String?,
  followUpDate: json['follow_up_date'] as String?,
  createdAt: json['created_at'] as String?,
  doctorName: json['doctor_name'] as String?,
  patientName: json['patient_name'] as String?,
  patientCode: json['patient_code'] as String?,
);

Map<String, dynamic> _$PrescriptionListItemToJson(
  PrescriptionListItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'diagnosis': instance.diagnosis,
  'chief_complaint': instance.chiefComplaint,
  'prescription_date': instance.prescriptionDate,
  'follow_up_date': instance.followUpDate,
  'created_at': instance.createdAt,
  'doctor_name': instance.doctorName,
  'patient_name': instance.patientName,
  'patient_code': instance.patientCode,
};

PrescriptionsListResponse _$PrescriptionsListResponseFromJson(
  Map<String, dynamic> json,
) => PrescriptionsListResponse(
  status: json['status'] as bool,
  statusCode: (json['status_code'] as num).toInt(),
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => PrescriptionListItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PrescriptionsListResponseToJson(
  PrescriptionsListResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};

MedicineItem _$MedicineItemFromJson(Map<String, dynamic> json) => MedicineItem(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  totalQuantity: json['total_quantity'] as String?,
  frequency: json['frequency'] as String?,
  routeForm: json['route_form'] as String?,
  noOfDays: json['no_of_days'] as String?,
  instructions: json['instructions'] as String?,
  additionalComments: json['additional_comments'] as String?,
);

Map<String, dynamic> _$MedicineItemToJson(MedicineItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'total_quantity': instance.totalQuantity,
      'frequency': instance.frequency,
      'route_form': instance.routeForm,
      'no_of_days': instance.noOfDays,
      'instructions': instance.instructions,
      'additional_comments': instance.additionalComments,
    };

LabTestItem _$LabTestItemFromJson(Map<String, dynamic> json) => LabTestItem(
  id: (json['id'] as num).toInt(),
  testName: json['test_name'] as String,
  additionalComments: json['additional_comments'] as String?,
);

Map<String, dynamic> _$LabTestItemToJson(LabTestItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'test_name': instance.testName,
      'additional_comments': instance.additionalComments,
    };

PrescriptionDetail _$PrescriptionDetailFromJson(Map<String, dynamic> json) =>
    PrescriptionDetail(
      id: (json['id'] as num).toInt(),
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
      prescriptionDate: json['prescription_date'] as String?,
      doctorName: json['doctor_name'] as String?,
      patientName: json['patient_name'] as String?,
      patientCode: json['patient_code'] as String?,
      gender: json['gender'] as String?,
      age: (json['age'] as num?)?.toInt(),
      patientPhone: json['patient_phone'] as String?,
      city: json['city'] as String?,
      medicines: (json['medicines'] as List<dynamic>?)
          ?.map((e) => MedicineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      labTests: (json['lab_tests'] as List<dynamic>?)
          ?.map((e) => LabTestItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PrescriptionDetailToJson(PrescriptionDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
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
      'prescription_date': instance.prescriptionDate,
      'doctor_name': instance.doctorName,
      'patient_name': instance.patientName,
      'patient_code': instance.patientCode,
      'gender': instance.gender,
      'age': instance.age,
      'patient_phone': instance.patientPhone,
      'city': instance.city,
      'medicines': instance.medicines,
      'lab_tests': instance.labTests,
    };

PrescriptionDetailResponse _$PrescriptionDetailResponseFromJson(
  Map<String, dynamic> json,
) => PrescriptionDetailResponse(
  status: json['status'] as bool,
  statusCode: (json['status_code'] as num).toInt(),
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : PrescriptionDetail.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PrescriptionDetailResponseToJson(
  PrescriptionDetailResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};

CreateMedicineResponse _$CreateMedicineResponseFromJson(
  Map<String, dynamic> json,
) => CreateMedicineResponse(
  status: json['status'] as bool,
  statusCode: (json['status_code'] as num).toInt(),
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : CreatePrescriptionData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateMedicineResponseToJson(
  CreateMedicineResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};

CreateLabTestResponse _$CreateLabTestResponseFromJson(
  Map<String, dynamic> json,
) => CreateLabTestResponse(
  status: json['status'] as bool,
  statusCode: (json['status_code'] as num).toInt(),
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : CreatePrescriptionData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateLabTestResponseToJson(
  CreateLabTestResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};
