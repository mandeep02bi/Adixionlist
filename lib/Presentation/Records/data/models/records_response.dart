import 'package:json_annotation/json_annotation.dart';

part 'records_response.g.dart';

@JsonSerializable()
class RecordsResponse {
  final bool status;
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String message;
  final RecordsData? data;

  RecordsResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory RecordsResponse.fromJson(Map<String, dynamic> json) =>
      _$RecordsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecordsResponseToJson(this);
}

@JsonSerializable()
class RecordsData {
  final List<RecordPrescription>? prescriptions;
  final List<RecordCertificate>? certificates;
  final List<RecordInstruction>? instructions;
  final List<RecordConsent>? consents;
  final List<RecordInvoice>? invoices;
  final List<RecordAppointment>? appointments;
  final List<RecordReminder>? reminders;

  RecordsData({
    this.prescriptions,
    this.certificates,
    this.instructions,
    this.consents,
    this.invoices,
    this.appointments,
    this.reminders,
  });

  factory RecordsData.fromJson(Map<String, dynamic> json) =>
      _$RecordsDataFromJson(json);

  Map<String, dynamic> toJson() => _$RecordsDataToJson(this);
}

@JsonSerializable()
class RecordPrescription {
  final int id;
  final String? diagnosis;
  @JsonKey(name: 'chief_complaint')
  final String? chiefComplaint;
  @JsonKey(name: 'prescription_date')
  final String? prescriptionDate;
  @JsonKey(name: 'doctor_name')
  final String? doctorName;

  RecordPrescription({
    required this.id,
    this.diagnosis,
    this.chiefComplaint,
    this.prescriptionDate,
    this.doctorName,
  });

  factory RecordPrescription.fromJson(Map<String, dynamic> json) =>
      _$RecordPrescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$RecordPrescriptionToJson(this);
}

@JsonSerializable()
class RecordCertificate {
  final int id;
  final String title;
  @JsonKey(name: 'certificate_date')
  final String certificateDate;
  @JsonKey(name: 'doctor_name')
  final String? doctorName;

  RecordCertificate({
    required this.id,
    required this.title,
    required this.certificateDate,
    this.doctorName,
  });

  factory RecordCertificate.fromJson(Map<String, dynamic> json) =>
      _$RecordCertificateFromJson(json);

  Map<String, dynamic> toJson() => _$RecordCertificateToJson(this);
}

@JsonSerializable()
class RecordInstruction {
  final int id;
  final String title;
  @JsonKey(name: 'instruction_date')
  final String instructionDate;
  @JsonKey(name: 'doctor_name')
  final String? doctorName;

  RecordInstruction({
    required this.id,
    required this.title,
    required this.instructionDate,
    this.doctorName,
  });

  factory RecordInstruction.fromJson(Map<String, dynamic> json) =>
      _$RecordInstructionFromJson(json);

  Map<String, dynamic> toJson() => _$RecordInstructionToJson(this);
}

@JsonSerializable()
class RecordConsent {
  final int id;
  final String title;
  @JsonKey(name: 'consent_date')
  final String consentDate;
  @JsonKey(name: 'doctor_name')
  final String? doctorName;

  RecordConsent({
    required this.id,
    required this.title,
    required this.consentDate,
    this.doctorName,
  });

  factory RecordConsent.fromJson(Map<String, dynamic> json) =>
      _$RecordConsentFromJson(json);

  Map<String, dynamic> toJson() => _$RecordConsentToJson(this);
}

@JsonSerializable()
class RecordInvoice {
  final int id;
  @JsonKey(name: 'invoice_title')
  final String invoiceTitle;
  @JsonKey(name: 'total_amount')
  final String totalAmount;
  final String status;

  RecordInvoice({
    required this.id,
    required this.invoiceTitle,
    required this.totalAmount,
    required this.status,
  });

  factory RecordInvoice.fromJson(Map<String, dynamic> json) =>
      _$RecordInvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$RecordInvoiceToJson(this);
}

@JsonSerializable()
class RecordAppointment {
  final int id;
  @JsonKey(name: 'appointment_date')
  final String appointmentDate;
  @JsonKey(name: 'appointment_time')
  final String appointmentTime;
  final String? purpose;
  final String status;
  @JsonKey(name: 'doctor_name')
  final String? doctorName;

  RecordAppointment({
    required this.id,
    required this.appointmentDate,
    required this.appointmentTime,
    this.purpose,
    required this.status,
    this.doctorName,
  });

  factory RecordAppointment.fromJson(Map<String, dynamic> json) =>
      _$RecordAppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$RecordAppointmentToJson(this);
}

@JsonSerializable()
class RecordReminder {
  final int id;
  final String title;
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'is_done')
  final int isDone;

  RecordReminder({
    required this.id,
    required this.title,
    required this.startDate,
    required this.isDone,
  });

  factory RecordReminder.fromJson(Map<String, dynamic> json) =>
      _$RecordReminderFromJson(json);

  Map<String, dynamic> toJson() => _$RecordReminderToJson(this);
}
