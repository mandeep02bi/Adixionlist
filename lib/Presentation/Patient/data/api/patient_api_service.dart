import 'package:dio/dio.dart';
import 'package:doctor/Core/networking/api_const.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_request_body.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_response.dart';
import 'package:doctor/Presentation/Patient/data/models/patients_list_response.dart';
import 'package:retrofit/retrofit.dart';

part 'patient_api_service.g.dart';

@RestApi(baseUrl: ApiConst.baseUrl)
abstract class PatientApiService {
  factory PatientApiService(Dio dio, {String? baseUrl}) = _PatientApiService;

  @POST(ApiConst.patientsEndpoint)
  Future<PatientResponse> addPatient(
    @Body() PatientRequestBody patientRequestBody,
  );

  @GET(ApiConst.patientsEndpoint)
  Future<PatientsListResponse> getPatients();
}
