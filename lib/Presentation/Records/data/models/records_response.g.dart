// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'records_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordsResponse _$RecordsResponseFromJson(Map<String, dynamic> json) =>
    RecordsResponse(
      status: json['status'] as bool,
      statusCode: (json['status_code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : RecordsData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecordsResponseToJson(RecordsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_code': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

RecordsData _$RecordsDataFromJson(Map<String, dynamic> json) => RecordsData(
  prescriptions: (json['prescriptions'] as List<dynamic>?)
      ?.map((e) => RecordPrescription.fromJson(e as Map<String, dynamic>))
      .toList(),
  certificates: (json['certificates'] as List<dynamic>?)
      ?.map((e) => RecordCertificate.fromJson(e as Map<String, dynamic>))
      .toList(),
  instructions: (json['instructions'] as List<dynamic>?)
      ?.map((e) => RecordInstruction.fromJson(e as Map<String, dynamic>))
      .toList(),
  consents: (json['consents'] as List<dynamic>?)
      ?.map((e) => RecordConsent.fromJson(e as Map<String, dynamic>))
      .toList(),
  invoices: (json['invoices'] as List<dynamic>?)
      ?.map((e) => RecordInvoice.fromJson(e as Map<String, dynamic>))
      .toList(),
  appointments: (json['appointments'] as List<dynamic>?)
      ?.map((e) => RecordAppointment.fromJson(e as Map<String, dynamic>))
      .toList(),
  reminders: (json['reminders'] as List<dynamic>?)
      ?.map((e) => RecordReminder.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RecordsDataToJson(RecordsData instance) =>
    <String, dynamic>{
      'prescriptions': instance.prescriptions,
      'certificates': instance.certificates,
      'instructions': instance.instructions,
      'consents': instance.consents,
      'invoices': instance.invoices,
      'appointments': instance.appointments,
      'reminders': instance.reminders,
    };

RecordPrescription _$RecordPrescriptionFromJson(Map<String, dynamic> json) =>
    RecordPrescription(
      id: (json['id'] as num).toInt(),
      diagnosis: json['diagnosis'] as String?,
      chiefComplaint: json['chief_complaint'] as String?,
      prescriptionDate: json['prescription_date'] as String?,
      doctorName: json['doctor_name'] as String?,
    );

Map<String, dynamic> _$RecordPrescriptionToJson(RecordPrescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'diagnosis': instance.diagnosis,
      'chief_complaint': instance.chiefComplaint,
      'prescription_date': instance.prescriptionDate,
      'doctor_name': instance.doctorName,
    };

RecordCertificate _$RecordCertificateFromJson(Map<String, dynamic> json) =>
    RecordCertificate(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      certificateDate: json['certificate_date'] as String,
      doctorName: json['doctor_name'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$RecordCertificateToJson(RecordCertificate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'certificate_date': instance.certificateDate,
      'doctor_name': instance.doctorName,
      'description': instance.description,
    };

RecordInstruction _$RecordInstructionFromJson(Map<String, dynamic> json) =>
    RecordInstruction(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      instructionDate: json['instruction_date'] as String,
      doctorName: json['doctor_name'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$RecordInstructionToJson(RecordInstruction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'instruction_date': instance.instructionDate,
      'doctor_name': instance.doctorName,
      'description': instance.description,
    };

RecordConsent _$RecordConsentFromJson(Map<String, dynamic> json) =>
    RecordConsent(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      consentDate: json['consent_date'] as String,
      doctorName: json['doctor_name'] as String?,
    );

Map<String, dynamic> _$RecordConsentToJson(RecordConsent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'consent_date': instance.consentDate,
      'doctor_name': instance.doctorName,
    };

RecordInvoice _$RecordInvoiceFromJson(Map<String, dynamic> json) =>
    RecordInvoice(
      id: (json['id'] as num).toInt(),
      invoiceTitle: json['invoice_title'] as String,
      totalAmount: json['total_amount'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$RecordInvoiceToJson(RecordInvoice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_title': instance.invoiceTitle,
      'total_amount': instance.totalAmount,
      'status': instance.status,
    };

RecordAppointment _$RecordAppointmentFromJson(Map<String, dynamic> json) =>
    RecordAppointment(
      id: (json['id'] as num).toInt(),
      appointmentDate: json['appointment_date'] as String,
      appointmentTime: json['appointment_time'] as String,
      purpose: json['purpose'] as String?,
      status: json['status'] as String,
      doctorName: json['doctor_name'] as String?,
    );

Map<String, dynamic> _$RecordAppointmentToJson(RecordAppointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointment_date': instance.appointmentDate,
      'appointment_time': instance.appointmentTime,
      'purpose': instance.purpose,
      'status': instance.status,
      'doctor_name': instance.doctorName,
    };

RecordReminder _$RecordReminderFromJson(Map<String, dynamic> json) =>
    RecordReminder(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      startDate: json['start_date'] as String,
      isDone: (json['is_done'] as num).toInt(),
    );

Map<String, dynamic> _$RecordReminderToJson(RecordReminder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'start_date': instance.startDate,
      'is_done': instance.isDone,
    };
