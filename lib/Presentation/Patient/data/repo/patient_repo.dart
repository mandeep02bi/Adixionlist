import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Core/networking/error_handler.dart';
import 'package:doctor/Presentation/Patient/data/api/patient_api_service.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_request_body.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_response.dart';
import 'package:doctor/Presentation/Patient/data/models/patients_list_response.dart';

class PatientRepo {
  final PatientApiService patientApiService;
  const PatientRepo({required this.patientApiService});

  Future<ApiResult<PatientResponse>> addPatient(
    PatientRequestBody patientRequestBody,
  ) async {
    try {
      final response = await patientApiService.addPatient(patientRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<PatientsListResponse>> getPatients() async {
    try {
      final response = await patientApiService.getPatients();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }
}
