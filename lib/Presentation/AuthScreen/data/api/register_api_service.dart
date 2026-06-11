import 'package:dio/dio.dart';
import 'package:doctor/Core/networking/api_const.dart';
import 'package:doctor/Presentation/AuthScreen/data/models/register_request_body.dart';
import 'package:doctor/Presentation/AuthScreen/data/models/register_response.dart';
import 'package:retrofit/retrofit.dart';

part 'register_api_service.g.dart';

@RestApi(baseUrl: ApiConst.baseUrl)
abstract class RegisterApiService {
  factory RegisterApiService(Dio dio, {String? baseUrl}) = _RegisterApiService;

  @POST(ApiConst.registerEndpoint)
  Future<RegisterResponse> register(
    @Body() RegisterRequestBody registerModel,
  );



}
