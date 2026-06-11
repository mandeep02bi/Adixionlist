import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse {
  final bool status;
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String message;

  ForgotPasswordResponse({
    required this.status,
    required this.statusCode,
    required this.message,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}
