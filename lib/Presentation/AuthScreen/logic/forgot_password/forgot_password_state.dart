import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState<T> with _$ForgotPasswordState<T> {
  const factory ForgotPasswordState.initial() = _Initial;
  
  const factory ForgotPasswordState.sendOtpLoading() = SendOtpLoading;
  const factory ForgotPasswordState.sendOtpSuccess(T data) = SendOtpSuccess<T>;
  const factory ForgotPasswordState.sendOtpError({required String message}) = SendOtpError;

  const factory ForgotPasswordState.verifyOtpLoading() = VerifyOtpLoading;
  const factory ForgotPasswordState.verifyOtpSuccess(T data) = VerifyOtpSuccess<T>;
  const factory ForgotPasswordState.verifyOtpError({required String message}) = VerifyOtpError;

  const factory ForgotPasswordState.resetPasswordLoading() = ResetPasswordLoading;
  const factory ForgotPasswordState.resetPasswordSuccess(T data) = ResetPasswordSuccess<T>;
  const factory ForgotPasswordState.resetPasswordError({required String message}) = ResetPasswordError;
}
