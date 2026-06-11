import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Core/networking/error_handler.dart';
import 'package:doctor/Presentation/Records/data/api/records_api_service.dart';
import 'package:doctor/Presentation/Records/data/models/records_response.dart';

class RecordsRepo {
  final RecordsApiService recordsApiService;
  const RecordsRepo({required this.recordsApiService});

  Future<ApiResult<RecordsResponse>> getRecords(
    String patientCode, {
    String? search,
  }) async {
    try {
      final response = await recordsApiService.getRecords(patientCode, search);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }
}
