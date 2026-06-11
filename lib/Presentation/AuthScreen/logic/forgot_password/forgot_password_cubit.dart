import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Presentation/AuthScreen/data/models/forgot_password_request_body.dart';
import 'package:doctor/Presentation/AuthScreen/data/repo/forgot_password_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor/Presentation/AuthScreen/logic/forgot_password/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepo repo;
  
  ForgotPasswordCubit({required this.repo}) : super(const ForgotPasswordState.initial());

  void emitSendOtpStates(String email) async {
    emit(const ForgotPasswordState.sendOtpLoading());
    final response = await repo.sendOtp(ForgotPasswordRequestBody(email: email));
    
    response.when(
      error: (error) {
        emit(ForgotPasswordState.sendOtpError(message: error.failure.message));
      },
      success: (data) {
        emit(ForgotPasswordState.sendOtpSuccess(data));
      },
    );
  }

  void emitVerifyOtpStates(String email, String otp) async {
    emit(const ForgotPasswordState.verifyOtpLoading());
    final response = await repo.verifyOtp(VerifyOtpRequestBody(email: email, otp: otp));
    
    response.when(
      error: (error) {
        emit(ForgotPasswordState.verifyOtpError(message: error.failure.message));
      },
      success: (data) {
        emit(ForgotPasswordState.verifyOtpSuccess(data));
      },
    );
  }

  void emitResetPasswordStates(String email, String newPassword) async {
    emit(const ForgotPasswordState.resetPasswordLoading());
    final response = await repo.resetPassword(ResetPasswordRequestBody(email: email, newPassword: newPassword));
    
    response.when(
      error: (error) {
        emit(ForgotPasswordState.resetPasswordError(message: error.failure.message));
      },
      success: (data) {
        emit(ForgotPasswordState.resetPasswordSuccess(data));
      },
    );
  }
}
