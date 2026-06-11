// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordRequestBody _$ForgotPasswordRequestBodyFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordRequestBody(email: json['email'] as String);

Map<String, dynamic> _$ForgotPasswordRequestBodyToJson(
  ForgotPasswordRequestBody instance,
) => <String, dynamic>{'email': instance.email};

VerifyOtpRequestBody _$VerifyOtpRequestBodyFromJson(
  Map<String, dynamic> json,
) => VerifyOtpRequestBody(
  email: json['email'] as String,
  otp: json['otp'] as String,
);

Map<String, dynamic> _$VerifyOtpRequestBodyToJson(
  VerifyOtpRequestBody instance,
) => <String, dynamic>{'email': instance.email, 'otp': instance.otp};

ResetPasswordRequestBody _$ResetPasswordRequestBodyFromJson(
  Map<String, dynamic> json,
) => ResetPasswordRequestBody(
  email: json['email'] as String,
  newPassword: json['new_password'] as String,
);

Map<String, dynamic> _$ResetPasswordRequestBodyToJson(
  ResetPasswordRequestBody instance,
) => <String, dynamic>{
  'email': instance.email,
  'new_password': instance.newPassword,
};
