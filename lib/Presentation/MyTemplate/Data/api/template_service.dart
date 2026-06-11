import 'package:dio/dio.dart';
import 'package:doctor/Core/networking/api_const.dart';
import 'package:doctor/Presentation/MyTemplate/Data/model/template_model.dart';
import 'package:doctor/Presentation/MyTemplate/Data/model/template_response.dart';
import 'package:retrofit/retrofit.dart';

part 'template_service.g.dart';

@RestApi(baseUrl: ApiConst.baseUrl)
abstract class TemplateApiService {
  factory TemplateApiService(Dio dio, {String? baseUrl}) = _TemplateApiService;

  @GET(ApiConst.templatesEndpoint)
  Future<TemplateResponse> getTemplates(@Query("type") String type);

  @GET("${ApiConst.templatesEndpoint}/{id}")
  Future<TemplateModel> getTemplateDetails(@Path("id") int id);

  @POST(ApiConst.templatesEndpoint)
  Future<dynamic> createTemplate(@Body() Map<String, dynamic> body);
}
