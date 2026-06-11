import 'package:dio/dio.dart';
import 'package:doctor/Core/networking/api_const.dart';
import 'package:doctor/Presentation/AuthScreen/data/models/forgot_password_request_body.dart';
import 'package:doctor/Presentation/AuthScreen/data/models/forgot_password_response.dart';
import 'package:retrofit/retrofit.dart';

part 'forgot_password_api_service.g.dart';

@RestApi(baseUrl: ApiConst.baseUrl)
abstract class ForgotPasswordApiService {
  factory ForgotPasswordApiService(Dio dio, {String? baseUrl}) = _ForgotPasswordApiService;

  @POST(ApiConst.forgotPasswordEndpoint)
  Future<ForgotPasswordResponse> sendOtp(
    @Body() ForgotPasswordRequestBody requestBody,
  );

  @POST(ApiConst.verifyOtpEndpoint)
  Future<ForgotPasswordResponse> verifyOtp(
    @Body() VerifyOtpRequestBody requestBody,
  );

  @POST(ApiConst.resetPasswordEndpoint)
  Future<ForgotPasswordResponse> resetPassword(
    @Body() ResetPasswordRequestBody requestBody,
  );
}
