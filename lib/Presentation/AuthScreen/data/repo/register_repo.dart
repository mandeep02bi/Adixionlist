import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Core/networking/error_handler.dart';
import 'package:doctor/Presentation/AuthScreen/data/api/register_api_service.dart';
import 'package:doctor/Presentation/AuthScreen/data/models/register_request_body.dart';
import 'package:doctor/Presentation/AuthScreen/data/models/register_response.dart';

class RegisterRepo {
  final RegisterApiService registerApiService;
  const RegisterRepo({required this.registerApiService});

  Future<ApiResult<RegisterResponse>> register(
    RegisterRequestBody registerRequestBody,
  ) async {
    try {
      final response = await registerApiService.register(registerRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }
}
