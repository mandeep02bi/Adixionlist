// // ─────────────────────────────────────────────────────────────────────────────
// // prescription_cubit.dart
// // ─────────────────────────────────────────────────────────────────────────────
// import 'package:doctor/Data/model/lab_test_request_body.dart';
// import 'package:doctor/Data/model/medicine_request_body.dart';
// import 'package:doctor/Data/model/prescription_request_body.dart';
// import 'package:doctor/Data/model/prescription_response.dart';
// import 'package:doctor/Data/repository/prescription_repository.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'prescription_state.dart';

// class PrescriptionCubit extends Cubit<PrescriptionState> {
//   final PrescriptionRepository _repository;

//   PrescriptionCubit(this._repository) : super(PrescriptionInitial());

//   /// Full flow:
//   /// 1. POST /prescriptions  → get prescriptionId
//   /// 2. POST medicines loop
//   /// 3. POST lab-tests loop
//   /// 4. GET /prescriptions/:id  → full data for PDF
//   Future<void> submitPrescription({
//     required PrescriptionRequestBody prescriptionBody,
//     required List<MedicineRequestBody> medicines,
//     required List<LabTestRequestBody> labTests,
//   }) async {
//     emit(PrescriptionLoading());

//     try {
//       // Step 1: Create prescription
//       emit(const PrescriptionProgress(message: 'Creating prescription...'));
//       final prescriptionResponse =
//           await _repository.createPrescription(prescriptionBody);

//       if (!prescriptionResponse.status ||
//           prescriptionResponse.data == null) {
//         emit(PrescriptionError(prescriptionResponse.message));
//         return;
//       }

//       final prescriptionId = prescriptionResponse.data!.id;

//       // Step 2: Add medicines
//       if (medicines.isNotEmpty) {
//         emit(PrescriptionProgress(
//           message: 'Adding ${medicines.length} medicine(s)...',
//         ));
//         await _repository.addMedicines(prescriptionId, medicines);
//       }

//       // Step 3: Add lab tests
//       if (labTests.isNotEmpty) {
//         emit(PrescriptionProgress(
//           message: 'Adding ${labTests.length} lab test(s)...',
//         ));
//         await _repository.addLabTests(prescriptionId, labTests);
//       }

//       // Step 4: Fetch full detail for PDF generation
//       emit(const PrescriptionProgress(message: 'Generating PDF...'));
//       final detailResponse =
//           await _repository.getPrescriptionById(prescriptionId);

//       if (!detailResponse.status || detailResponse.data == null) {
//         emit(PrescriptionError(detailResponse.message));
//         return;
//       }

//       emit(PrescriptionSuccess(
//         prescriptionId: prescriptionId,
//         detail: detailResponse.data!,
//       ));
//     } catch (e) {
//       emit(PrescriptionError(e.toString()));
//     }
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doctor/Data/model/lab_test_request_body.dart';
import 'package:doctor/Data/model/medicine_request_body.dart';
import 'package:doctor/Data/model/prescription_request_body.dart';
import 'package:doctor/Data/repository/prescription_repository.dart';

import 'prescription_state.dart';

class PrescriptionCubit extends Cubit<PrescriptionState> {
  final PrescriptionRepo prescriptionRepo;

  PrescriptionCubit({required this.prescriptionRepo})
    : super(PrescriptionInitial());

  /// ======================================
  /// CREATE FULL PRESCRIPTION FLOW
  /// ======================================
  Future<void> createFullPrescription({
    required PrescriptionRequestBody prescriptionBody,
    required List<MedicineRequestBody> medicines,
    required List<LabTestRequestBody> labTests,
  }) async {
    try {
      emit(PrescriptionLoading());

      /// CREATE PRESCRIPTION

      final prescriptionResponse = await prescriptionRepo.createPrescription(
        prescriptionBody,
      );

      final prescriptionId = prescriptionResponse.data.id;

      emit(PrescriptionProgress("Adding Medicines..."));

      /// ADD MEDICINES

      for (var medicine in medicines) {
        await prescriptionRepo.addMedicine(prescriptionId, medicine);
      }

      emit(PrescriptionProgress("Adding Lab Tests..."));

      /// ADD LAB TESTS

      for (var labTest in labTests) {
        await prescriptionRepo.addLabTest(prescriptionId, labTest);
      }

      /// FETCH FINAL DETAIL
      final response = await prescriptionRepo.getPrescriptionById(
        prescriptionId,
      );

      if (response.data == null) {
        throw Exception("Prescription detail not found");
      }

      emit(PrescriptionSuccess(response.data!));
    } catch (e) {
      String message = "Something went wrong";

      if (e is DioException) {
        message =
            e.response?.data?['message'] ?? e.message ?? "Something went wrong";
      }

      emit(PrescriptionError(message));
    }
  }
}
