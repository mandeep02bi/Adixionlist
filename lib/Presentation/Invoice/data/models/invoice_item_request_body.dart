import 'package:json_annotation/json_annotation.dart';

part 'invoice_item_request_body.g.dart';

@JsonSerializable()
class InvoiceItemRequestBody {
  final String description;
  final double amount;

  InvoiceItemRequestBody({
    required this.description,
    required this.amount,
  });

  factory InvoiceItemRequestBody.fromJson(Map<String, dynamic> json) =>
      _$InvoiceItemRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceItemRequestBodyToJson(this);
}
