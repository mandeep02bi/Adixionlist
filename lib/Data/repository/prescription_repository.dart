// import 'package:doctor/Data/Api/prescription_api_service.dart';
// import 'package:doctor/Data/model/lab_test_request_body.dart';
// import 'package:doctor/Data/model/medicine_request_body.dart';
// import 'package:doctor/Data/model/prescription_request_body.dart';
// import 'package:doctor/Data/model/prescription_response.dart';

// class PrescriptionRepository {
//   final PrescriptionApiService _apiService;

//   PrescriptionRepository(this._apiService);

//   Future<CreatePrescriptionResponse> createPrescription(
//     PrescriptionRequestBody body,
//   ) async {
//     return await _apiService.createPrescription(body);
//   }

//   Future<void> addMedicines(
//     int prescriptionId,
//     List<MedicineRequestBody> medicines,
//   ) async {
//     for (final medicine in medicines) {
//       await _apiService.addMedicine(prescriptionId, medicine);
//     }
//   }

//   Future<void> addLabTests(
//     int prescriptionId,
//     List<LabTestRequestBody> labTests,
//   ) async {
//     for (final test in labTests) {
//       await _apiService.addLabTest(prescriptionId, test);
//     }
//   }

//   Future<PrescriptionDetailResponse> getPrescriptionById(int id) async {
//     return await _apiService.getPrescriptionById(id);
//   }

//   Future<PrescriptionsListResponse> getPrescriptions({
//     String? patientCode,
//     String? sort,
//   }) async {
//     return await _apiService.getPrescriptions(patientCode, sort);
//   }
// }

import 'package:doctor/Data/Api/prescription_api_service.dart';

import '../../../../Data/model/lab_test_request_body.dart';
import '../../../../Data/model/medicine_request_body.dart';
import '../../../../Data/model/prescription_request_body.dart';

class PrescriptionRepo {
  final PrescriptionApiService prescriptionApiService;

  PrescriptionRepo({required this.prescriptionApiService});

  /// ============================
  /// CREATE PRESCRIPTION
  /// ============================

  Future createPrescription(PrescriptionRequestBody body) async {
    return await prescriptionApiService.createPrescription(body);
  }

  /// ============================
  /// ADD MEDICINE
  /// ============================

  Future addMedicine(int prescriptionId, MedicineRequestBody body) async {
    return await prescriptionApiService.addMedicine(prescriptionId, body);
  }

  /// ============================
  /// ADD LAB TEST
  /// ============================

  Future addLabTest(int prescriptionId, LabTestRequestBody body) async {
    return await prescriptionApiService.addLabTest(prescriptionId, body);
  }

  /// ============================
  /// GET PRESCRIPTION DETAIL
  /// ============================

  Future getPrescriptionById(int id) async {
    return await prescriptionApiService.getPrescriptionById(id);
  }
}
