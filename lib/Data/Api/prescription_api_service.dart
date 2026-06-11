import 'package:dio/dio.dart';
import 'package:doctor/Core/networking/api_const.dart';
import 'package:doctor/Data/model/lab_test_request_body.dart';
import 'package:doctor/Data/model/medicine_request_body.dart';
import 'package:doctor/Data/model/prescription_request_body.dart';
import 'package:doctor/Data/model/prescription_response.dart';
import 'package:retrofit/retrofit.dart';

part 'prescription_api_service.g.dart';

@RestApi(baseUrl: ApiConst.baseUrl)
abstract class PrescriptionApiService {
  factory PrescriptionApiService(Dio dio, {String? baseUrl}) =
      _PrescriptionApiService;

  // #24 POST /api/prescriptions
  @POST(ApiConst.prescriptions)
  Future<CreatePrescriptionResponse> createPrescription(
    @Body() PrescriptionRequestBody body,
  );

  // #25 GET /api/prescriptions
  @GET(ApiConst.prescriptions)
  Future<PrescriptionsListResponse> getPrescriptions(
    @Query('patient_code') String? patientCode,
    @Query('sort') String? sort,
  );

  // #26 GET /api/prescriptions/:id
  @GET('${ApiConst.prescriptions}/{id}')
  Future<PrescriptionDetailResponse> getPrescriptionById(
    @Path('id') int id,
  );

  // #27 PUT /api/prescriptions/:id
  @PUT('${ApiConst.prescriptions}/{id}')
  Future<BaseApiResponse> updatePrescription(
    @Path('id') int id,
    @Body() PrescriptionRequestBody body,
  );

  // #28 DELETE /api/prescriptions/:id
  @DELETE('${ApiConst.prescriptions}/{id}')
  Future<BaseApiResponse> deletePrescription(
    @Path('id') int id,
  );

  // #29 POST /api/prescriptions/:id/medicines
  @POST('${ApiConst.prescriptions}/{id}/medicines')
  Future<CreateMedicineResponse> addMedicine(
    @Path('id') int prescriptionId,
    @Body() MedicineRequestBody body,
  );

  // #30 PUT /api/prescriptions/:id/medicines/:medicineId
  @PUT('${ApiConst.prescriptions}/{id}/medicines/{medicineId}')
  Future<BaseApiResponse> updateMedicine(
    @Path('id') int prescriptionId,
    @Path('medicineId') int medicineId,
    @Body() MedicineRequestBody body,
  );

  // #31 DELETE /api/prescriptions/:id/medicines/:medicineId
  @DELETE('${ApiConst.prescriptions}/{id}/medicines/{medicineId}')
  Future<BaseApiResponse> deleteMedicine(
    @Path('id') int prescriptionId,
    @Path('medicineId') int medicineId,
  );

  // #32 POST /api/prescriptions/:id/lab-tests
  @POST('${ApiConst.prescriptions}/{id}/lab-tests')
  Future<CreateLabTestResponse> addLabTest(
    @Path('id') int prescriptionId,
    @Body() LabTestRequestBody body,
  );

  // #33 PUT /api/prescriptions/:id/lab-tests/:labTestId
  @PUT('${ApiConst.prescriptions}/{id}/lab-tests/{labTestId}')
  Future<BaseApiResponse> updateLabTest(
    @Path('id') int prescriptionId,
    @Path('labTestId') int labTestId,
    @Body() LabTestRequestBody body,
  );

  // #34 DELETE /api/prescriptions/:id/lab-tests/:labTestId
  @DELETE('${ApiConst.prescriptions}/{id}/lab-tests/{labTestId}')
  Future<BaseApiResponse> deleteLabTest(
    @Path('id') int prescriptionId,
    @Path('labTestId') int labTestId,
  );
}
