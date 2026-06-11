// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceRequestBody _$InvoiceRequestBodyFromJson(Map<String, dynamic> json) =>
    InvoiceRequestBody(
      patientCode: json['patient_code'] as String,
      billToName: json['bill_to_name'] as String,
      invoiceTitle: json['invoice_title'] as String,
      currency: json['currency'] as String? ?? "INR",
      discountTitle: json['discount_title'] as String?,
      discountValue: (json['discount_value'] as num?)?.toDouble(),
      discountType: json['discount_type'] as String?,
      advanceTitle: json['advance_title'] as String?,
      advanceAmount: (json['advance_amount'] as num?)?.toDouble(),
      taxTitle: json['tax_title'] as String?,
      taxValue: (json['tax_value'] as num?)?.toDouble(),
      taxType: json['tax_type'] as String?,
      remark: json['remark'] as String?,
      invoiceDate: json['invoice_date'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$InvoiceRequestBodyToJson(InvoiceRequestBody instance) =>
    <String, dynamic>{
      'patient_code': instance.patientCode,
      'bill_to_name': instance.billToName,
      'invoice_title': instance.invoiceTitle,
      'currency': instance.currency,
      'discount_title': instance.discountTitle,
      'discount_value': instance.discountValue,
      'discount_type': instance.discountType,
      'advance_title': instance.advanceTitle,
      'advance_amount': instance.advanceAmount,
      'tax_title': instance.taxTitle,
      'tax_value': instance.taxValue,
      'tax_type': instance.taxType,
      'remark': instance.remark,
      'invoice_date': instance.invoiceDate,
      'status': instance.status,
    };
