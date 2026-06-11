import 'package:dio/dio.dart';
import 'package:doctor/Core/networking/api_const.dart';
import 'package:doctor/Presentation/Certificate/data/models/certificate_request_body.dart';
import 'package:doctor/Presentation/Certificate/data/models/certificate_response.dart';
import 'package:retrofit/retrofit.dart';

part 'certificate_api_service.g.dart';

@RestApi(baseUrl: ApiConst.baseUrl)
abstract class CertificateApiService {
  factory CertificateApiService(Dio dio, {String? baseUrl}) = _CertificateApiService;

  @POST(ApiConst.certificates)
  Future<CertificateResponse> createCertificate(
    @Body() CertificateRequestBody body,
  );

  @GET(ApiConst.certificates)
  Future<CertificateListResponse> getCertificates(
    @Query('patient_code') String? patientCode,
    @Query('sort') String? sort,
  );
}
