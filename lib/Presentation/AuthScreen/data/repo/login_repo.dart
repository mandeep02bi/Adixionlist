import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Core/networking/error_handler.dart';
import 'package:doctor/Presentation/AuthScreen/data/api/login_api_service.dart';
import 'package:doctor/Presentation/AuthScreen/data/models/login_request_body.dart';
import 'package:doctor/Presentation/AuthScreen/data/models/login_response.dart';

class LoginRepo {
  final LoginApiService loginApiService;

  LoginRepo({required this.loginApiService});

  Future<ApiResult<LoginResponse>> login(
    LoginRequestBody loginRequestBody,
  ) async {
    try {
      final response = await loginApiService.login(loginRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }
}
