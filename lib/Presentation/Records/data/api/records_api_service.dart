import 'package:dio/dio.dart';
import 'package:doctor/Core/networking/api_const.dart';
import 'package:doctor/Presentation/Records/data/models/records_response.dart';
import 'package:retrofit/retrofit.dart';

part 'records_api_service.g.dart';

@RestApi(baseUrl: ApiConst.baseUrl)
abstract class RecordsApiService {
  factory RecordsApiService(Dio dio, {String? baseUrl}) = _RecordsApiService;

  @GET(ApiConst.records)
  Future<RecordsResponse> getRecords(
    @Query('patient_code') String patientCode,
    @Query('search') String? search,
  );
}
