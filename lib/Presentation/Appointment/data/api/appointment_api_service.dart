import 'package:dio/dio.dart';
import 'package:doctor/Core/networking/api_const.dart';
import 'package:doctor/Presentation/Appointment/data/models/appointment_request_body.dart';
import 'package:doctor/Presentation/Appointment/data/models/appointment_response.dart';
import 'package:retrofit/retrofit.dart';

part 'appointment_api_service.g.dart';

@RestApi(baseUrl: ApiConst.baseUrl)
abstract class AppointmentApiService {
  factory AppointmentApiService(Dio dio, {String? baseUrl}) = _AppointmentApiService;

  @POST(ApiConst.appointments)
  Future<AppointmentResponse> bookAppointment(
    @Body() AppointmentRequestBody body,
  );
}
