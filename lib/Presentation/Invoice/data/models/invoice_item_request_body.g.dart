// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_item_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceItemRequestBody _$InvoiceItemRequestBodyFromJson(
  Map<String, dynamic> json,
) => InvoiceItemRequestBody(
  description: json['description'] as String,
  amount: (json['amount'] as num).toDouble(),
);

Map<String, dynamic> _$InvoiceItemRequestBodyToJson(
  InvoiceItemRequestBody instance,
) => <String, dynamic>{
  'description': instance.description,
  'amount': instance.amount,
};
