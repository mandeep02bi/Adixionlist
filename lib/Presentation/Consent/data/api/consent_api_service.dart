// import 'package:dio/dio.dart';
// import 'package:retrofit/retrofit.dart';

// import '../model/consent_model.dart';
// import '../model/consent_response.dart';
// import '../../../../Core/networking/api_const.dart';

// part 'consent_api_service.g.dart';

// @RestApi(baseUrl: ApiConst.baseUrl)
// abstract class ConsentApiService {
//   factory ConsentApiService(Dio dio, {String? baseUrl}) = _ConsentApiService;

//   @GET(ApiConst.consentEndpoint)
//   Future<ConsentResponse> getConsents(
//     @Query("patient_code") String? patientCode,
//   );

//   @GET("${ApiConst.consentEndpoint}/{id}")
//   Future<ConsentModel> getConsentDetails(@Path("id") int id);

//   @POST(ApiConst.consentEndpoint)
//   Future<dynamic> createConsent(@Body() Map<String, dynamic> body);

//   @DELETE("${ApiConst.consentEndpoint}/{id}")
//   Future<dynamic> deleteConsent(@Path("id") int id);
// }
