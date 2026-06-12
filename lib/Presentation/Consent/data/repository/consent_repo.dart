// import 'package:doctor/Core/networking/api_result.dart';
// import 'package:doctor/Core/networking/error_handler.dart';

// import '../api/consent_api_service.dart';
// import '../model/consent_model.dart';
// import '../model/consent_response.dart';

// class ConsentRepository {
//   final ConsentApiService consentApiService;

//   ConsentRepository({required this.consentApiService});

//   Future<ApiResult<ConsentResponse>> getConsents(String? patientCode) async {
//     try {
//       final response = await consentApiService.getConsents(patientCode);

//       return ApiResult.success(response);
//     } catch (e) {
//       return ApiResult.error(ErrorHandler.handle(e));
//     }
//   }

//   Future<ApiResult<ConsentModel>> getConsentDetails(int id) async {
//     try {
//       final response = await consentApiService.getConsentDetails(id);

//       return ApiResult.success(response);
//     } catch (e) {
//       return ApiResult.error(ErrorHandler.handle(e));
//     }
//   }

//   Future<ApiResult<dynamic>> createConsent({
//     required String patientCode,
//     required String title,
//     required String description,
//     required String consentDate,
//   }) async {
//     try {
//       final response = await consentApiService.createConsent({
//         "patient_code": patientCode,
//         "title": title,
//         "description": description,
//         "consent_date": consentDate,
//       });

//       return ApiResult.success(response);
//     } catch (e) {
//       return ApiResult.error(ErrorHandler.handle(e));
//     }
//   }

//   Future<ApiResult<dynamic>> deleteConsent(int id) async {
//     try {
//       final response = await consentApiService.deleteConsent(id);

//       return ApiResult.success(response);
//     } catch (e) {
//       return ApiResult.error(ErrorHandler.handle(e));
//     }
//   }
// }
