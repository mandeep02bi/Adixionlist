import 'package:json_annotation/json_annotation.dart';

part 'invoice_request_body.g.dart';

@JsonSerializable()
class InvoiceRequestBody {
  @JsonKey(name: 'patient_code')
  final String patientCode;
  @JsonKey(name: 'bill_to_name')
  final String billToName;
  @JsonKey(name: 'invoice_title')
  final String invoiceTitle;
  final String currency;
  @JsonKey(name: 'discount_title')
  final String? discountTitle;
  @JsonKey(name: 'discount_value')
  final double? discountValue;
  @JsonKey(name: 'discount_type')
  final String? discountType;
  @JsonKey(name: 'advance_title')
  final String? advanceTitle;
  @JsonKey(name: 'advance_amount')
  final double? advanceAmount;
  @JsonKey(name: 'tax_title')
  final String? taxTitle;
  @JsonKey(name: 'tax_value')
  final double? taxValue;
  @JsonKey(name: 'tax_type')
  final String? taxType;
  final String? remark;
  @JsonKey(name: 'invoice_date')
  final String invoiceDate;
  final String status;

  InvoiceRequestBody({
    required this.patientCode,
    required this.billToName,
    required this.invoiceTitle,
    this.currency = "INR",
    this.discountTitle,
    this.discountValue,
    this.discountType,
    this.advanceTitle,
    this.advanceAmount,
    this.taxTitle,
    this.taxValue,
    this.taxType,
    this.remark,
    required this.invoiceDate,
    required this.status,
  });

  factory InvoiceRequestBody.fromJson(Map<String, dynamic> json) =>
      _$InvoiceRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceRequestBodyToJson(this);
}
