// import 'package:doctor/Core/networking/api_result.dart';
// import 'package:doctor/Presentation/Consent/data/repository/consent_repo.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'consent_state.dart';

// class ConsentCubit extends Cubit<ConsentState> {
//   final ConsentRepository consentRepository;

//   ConsentCubit({required this.consentRepository}) : super(ConsentInitial());

//   // Future<void> getConsents(String? patientCode) async {
//   //   emit(ConsentLoading());

//   //   final result = await consentRepository.getConsents(patientCode);

//   //   result.when(
//   //     success: (response) {
//   //       emit(ConsentLoaded(response.data ?? []));
//   //     },
//   //     error: (error) {
//   //       emit(ConsentError(error.toString()));
//   //     },
//   //   );
//   // }

//   // Future<void> getConsentDetails(int id) async {
//   //   emit(ConsentLoading());

//   //   final result = await consentRepository.getConsentDetails(id);

//   //   result.when(
//   //     success: (response) {
//   //       emit(ConsentDetailsLoaded(response));
//   //     },
//   //     error: (error) {
//   //       emit(ConsentError(error.toString()));
//   //     },
//   //   );
//   // }

//   Future<bool> createConsent({
//     required String patientCode,
//     required String title,
//     required String description,
//     required String consentDate,
//   }) async {
//     final result = await consentRepository.createConsent(
//       patientCode: patientCode,
//       title: title,
//       description: description,
//       consentDate: consentDate,
//     );

//     bool success = false;

//     result.when(
//       success: (_) {
//         success = true;

//         emit(ConsentCreated("Consent Created Successfully"));
//       },
//       error: (error) {
//         emit(ConsentError(error.toString()));
//       },
//     );

//     return success;
//     // }

//     // Future<void> deleteConsent(int id, String? patientCode) async {
//     //   final result = await consentRepository.deleteConsent(id);

//     //   result.when(
//     //     success: (_) async {
//     //       emit(ConsentDeleted("Consent Deleted Successfully"));

//     //       await getConsents(patientCode);
//     //     },
//     //     error: (error) {
//     //       emit(ConsentError(error.toString()));
//     //     },
//     //   );
//     // }
//   }
// }
