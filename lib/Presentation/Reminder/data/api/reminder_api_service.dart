import 'package:dio/dio.dart';
import 'package:doctor/Core/networking/api_const.dart';
import 'package:doctor/Presentation/Reminder/data/models/reminder_request_body.dart';
import 'package:doctor/Presentation/Reminder/data/models/reminder_response.dart';
import 'package:retrofit/retrofit.dart';

part 'reminder_api_service.g.dart';

@RestApi(baseUrl: ApiConst.baseUrl)
abstract class ReminderApiService {
  factory ReminderApiService(Dio dio, {String? baseUrl}) = _ReminderApiService;

  @POST(ApiConst.reminders)
  Future<ReminderResponse> createReminder(
    @Body() ReminderRequestBody body,
  );

  @GET(ApiConst.reminders)
  Future<ReminderListResponse> getReminders(
    @Query('patient_code') String? patientCode,
    @Query('reminder_type') String? reminderType,
  );
}
