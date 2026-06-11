import 'package:dio/dio.dart';
import 'package:doctor/Core/networking/api_const.dart';
import 'package:doctor/Presentation/AuthScreen/data/models/login_request_body.dart';
import 'package:doctor/Presentation/AuthScreen/data/models/login_response.dart';
import 'package:retrofit/retrofit.dart';

part 'login_api_service.g.dart';

@RestApi(baseUrl: ApiConst.baseUrl)
abstract class LoginApiService {
  factory LoginApiService(Dio dio, {String? baseUrl}) = _LoginApiService;

  @POST(ApiConst.loginEndpoint)
  Future<LoginResponse> login(
    @Body() LoginRequestBody loginRequestBody,
  );
}
