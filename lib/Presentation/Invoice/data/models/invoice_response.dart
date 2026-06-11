import 'package:json_annotation/json_annotation.dart';

part 'invoice_response.g.dart';

@JsonSerializable()
class InvoiceResponse {
  final bool status;
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String message;
  final InvoiceResponseData? data;

  InvoiceResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) =>
      _$InvoiceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceResponseToJson(this);
}

@JsonSerializable()
class InvoiceListResponse {
  final bool status;
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String message;
  final List<InvoiceResponseData>? data;

  InvoiceListResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory InvoiceListResponse.fromJson(Map<String, dynamic> json) =>
      _$InvoiceListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceListResponseToJson(this);
}

@JsonSerializable()
class InvoiceItemData {
  final int id;
  final String description;
  final String amount; // sometimes dynamic type or String from server

  InvoiceItemData({
    required this.id,
    required this.description,
    required this.amount,
  });

  factory InvoiceItemData.fromJson(Map<String, dynamic> json) =>
      _$InvoiceItemDataFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceItemDataToJson(this);
}

@JsonSerializable()
class InvoiceResponseData {
  final int id;
  @JsonKey(name: 'patient_code')
  final String? patientCode;
  @JsonKey(name: 'patient_name')
  final String? patientName;
  @JsonKey(name: 'bill_to_name')
  final String? billToName;
  @JsonKey(name: 'invoice_title')
  final String? invoiceTitle;
  final String? currency;
  @JsonKey(name: 'discount_title')
  final String? discountTitle;
  @JsonKey(name: 'discount_value')
  final String? discountValue;
  @JsonKey(name: 'discount_type')
  final String? discountType;
  @JsonKey(name: 'advance_title')
  final String? advanceTitle;
  @JsonKey(name: 'advance_amount')
  final String? advanceAmount;
  @JsonKey(name: 'tax_title')
  final String? taxTitle;
  @JsonKey(name: 'tax_value')
  final String? taxValue;
  @JsonKey(name: 'tax_type')
  final String? taxType;
  final String? remark;
  @JsonKey(name: 'invoice_date')
  final String? invoiceDate;
  @JsonKey(name: 'total_amount')
  final String? totalAmount;
  final String? status;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'created_by_name')
  final String? createdByName;
  final List<InvoiceItemData>? items;

  InvoiceResponseData({
    required this.id,
    this.patientCode,
    this.patientName,
    this.billToName,
    this.invoiceTitle,
    this.currency,
    this.discountTitle,
    this.discountValue,
    this.discountType,
    this.advanceTitle,
    this.advanceAmount,
    this.taxTitle,
    this.taxValue,
    this.taxType,
    this.remark,
    this.invoiceDate,
    this.totalAmount,
    this.status,
    this.createdAt,
    this.createdByName,
    this.items,
  });

  factory InvoiceResponseData.fromJson(Map<String, dynamic> json) =>
      _$InvoiceResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceResponseDataToJson(this);
}
