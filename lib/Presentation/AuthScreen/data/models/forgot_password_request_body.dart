import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request_body.g.dart';

@JsonSerializable()
class ForgotPasswordRequestBody {
  final String email;

  ForgotPasswordRequestBody({required this.email});

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestBodyToJson(this);
}

@JsonSerializable()
class VerifyOtpRequestBody {
  final String email;
  final String otp;

  VerifyOtpRequestBody({required this.email, required this.otp});

  Map<String, dynamic> toJson() => _$VerifyOtpRequestBodyToJson(this);
}

@JsonSerializable()
class ResetPasswordRequestBody {
  final String email;
  @JsonKey(name: 'new_password')
  final String newPassword;

  ResetPasswordRequestBody({required this.email, required this.newPassword});

  Map<String, dynamic> toJson() => _$ResetPasswordRequestBodyToJson(this);
}
