// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceResponse _$InvoiceResponseFromJson(Map<String, dynamic> json) =>
    InvoiceResponse(
      status: json['status'] as bool,
      statusCode: (json['status_code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : InvoiceResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvoiceResponseToJson(InvoiceResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_code': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

InvoiceListResponse _$InvoiceListResponseFromJson(Map<String, dynamic> json) =>
    InvoiceListResponse(
      status: json['status'] as bool,
      statusCode: (json['status_code'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => InvoiceResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InvoiceListResponseToJson(
  InvoiceListResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_code': instance.statusCode,
  'message': instance.message,
  'data': instance.data,
};

InvoiceItemData _$InvoiceItemDataFromJson(Map<String, dynamic> json) =>
    InvoiceItemData(
      id: (json['id'] as num).toInt(),
      description: json['description'] as String,
      amount: json['amount'] as String,
    );

Map<String, dynamic> _$InvoiceItemDataToJson(InvoiceItemData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'amount': instance.amount,
    };

InvoiceResponseData _$InvoiceResponseDataFromJson(Map<String, dynamic> json) =>
    InvoiceResponseData(
      id: (json['id'] as num).toInt(),
      patientCode: json['patient_code'] as String?,
      patientName: json['patient_name'] as String?,
      billToName: json['bill_to_name'] as String?,
      invoiceTitle: json['invoice_title'] as String?,
      currency: json['currency'] as String?,
      discountTitle: json['discount_title'] as String?,
      discountValue: json['discount_value'] as String?,
      discountType: json['discount_type'] as String?,
      advanceTitle: json['advance_title'] as String?,
      advanceAmount: json['advance_amount'] as String?,
      taxTitle: json['tax_title'] as String?,
      taxValue: json['tax_value'] as String?,
      taxType: json['tax_type'] as String?,
      remark: json['remark'] as String?,
      invoiceDate: json['invoice_date'] as String?,
      totalAmount: json['total_amount'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      createdByName: json['created_by_name'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => InvoiceItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InvoiceResponseDataToJson(
  InvoiceResponseData instance,
) => <String, dynamic>{
  'id': instance.id,
  'patient_code': instance.patientCode,
  'patient_name': instance.patientName,
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
  'total_amount': instance.totalAmount,
  'status': instance.status,
  'created_at': instance.createdAt,
  'created_by_name': instance.createdByName,
  'items': instance.items,
};
