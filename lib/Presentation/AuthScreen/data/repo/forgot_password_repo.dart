import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Core/networking/error_handler.dart';
import 'package:doctor/Presentation/AuthScreen/data/api/forgot_password_api_service.dart';
import 'package:doctor/Presentation/AuthScreen/data/models/forgot_password_request_body.dart';
import 'package:doctor/Presentation/AuthScreen/data/models/forgot_password_response.dart';

class ForgotPasswordRepo {
  final ForgotPasswordApiService apiService;

  ForgotPasswordRepo({required this.apiService});

  Future<ApiResult<ForgotPasswordResponse>> sendOtp(
    ForgotPasswordRequestBody requestBody,
  ) async {
    try {
      final response = await apiService.sendOtp(requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ForgotPasswordResponse>> verifyOtp(
    VerifyOtpRequestBody requestBody,
  ) async {
    try {
      final response = await apiService.verifyOtp(requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ForgotPasswordResponse>> resetPassword(
    ResetPasswordRequestBody requestBody,
  ) async {
    try {
      final response = await apiService.resetPassword(requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }
}
