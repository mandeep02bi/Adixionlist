import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Core/networking/error_handler.dart';
import 'package:doctor/Presentation/Appointment/data/api/appointment_api_service.dart';
import 'package:doctor/Presentation/Appointment/data/models/appointment_list_response.dart';
import 'package:doctor/Presentation/Appointment/data/models/appointment_request_body.dart';
import 'package:doctor/Presentation/Appointment/data/models/appointment_response.dart';

class AppointmentRepo {
  final AppointmentApiService appointmentApiService;
  const AppointmentRepo({required this.appointmentApiService});

  Future<ApiResult<AppointmentResponse>> bookAppointment(
    AppointmentRequestBody body,
  ) async {
    try {
      final response = await appointmentApiService.bookAppointment(body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<AppointmentListResponse>> getAppointments() async {
    try {
      final response = await appointmentApiService.getAppointments();

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<AppointmentResponse>> getAppointmentById(int id) async {
    try {
      final response = await appointmentApiService.getAppointmentById(id);

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<AppointmentResponse>> updateAppointment(
    int id,
    AppointmentRequestBody body,
  ) async {
    try {
      final response = await appointmentApiService.updateAppointment(id, body);

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }
}
