import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Core/networking/error_handler.dart';
import 'package:doctor/Presentation/Reminder/data/api/reminder_api_service.dart';
import 'package:doctor/Presentation/Reminder/data/models/reminder_request_body.dart';
import 'package:doctor/Presentation/Reminder/data/models/reminder_response.dart';

class ReminderRepo {
  final ReminderApiService reminderApiService;
  const ReminderRepo({required this.reminderApiService});

  Future<ApiResult<ReminderResponse>> createReminder(
    ReminderRequestBody body,
  ) async {
    try {
      final response = await reminderApiService.createReminder(body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ReminderListResponse>> getReminders({
    String? patientCode,
    String? reminderType,
  }) async {
    try {
      final response = await reminderApiService.getReminders(patientCode, reminderType);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ReminderResponse>> updateReminder({
    required int id,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response =
      await reminderApiService.updateReminder(id, body);

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ReminderResponse>> deleteReminder(
      int id,
      ) async {
    try {
      final response =
      await reminderApiService.deleteReminder(id);

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }
}
