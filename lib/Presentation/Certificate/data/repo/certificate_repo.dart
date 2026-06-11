import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Core/networking/error_handler.dart';
import 'package:doctor/Presentation/Certificate/data/api/certificate_api_service.dart';
import 'package:doctor/Presentation/Certificate/data/models/certificate_request_body.dart';
import 'package:doctor/Presentation/Certificate/data/models/certificate_response.dart';

class CertificateRepo {
  final CertificateApiService certificateApiService;
  const CertificateRepo({required this.certificateApiService});

  Future<ApiResult<CertificateResponse>> createCertificate(
    CertificateRequestBody body,
  ) async {
    try {
      final response = await certificateApiService.createCertificate(body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<CertificateListResponse>> getCertificates(
    String? patientCode, {
    String? sort,
  }) async {
    try {
      final response = await certificateApiService.getCertificates(patientCode, sort);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }
}
