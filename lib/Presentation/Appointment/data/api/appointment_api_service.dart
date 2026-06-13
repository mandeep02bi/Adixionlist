import 'package:dio/dio.dart';
import 'package:doctor/Core/networking/api_const.dart';
import 'package:doctor/Presentation/Appointment/data/models/appointment_list_response.dart';
import 'package:doctor/Presentation/Appointment/data/models/appointment_request_body.dart';
import 'package:doctor/Presentation/Appointment/data/models/appointment_response.dart';
import 'package:retrofit/retrofit.dart';

part 'appointment_api_service.g.dart';

@RestApi(baseUrl: ApiConst.baseUrl)
abstract class AppointmentApiService {
  factory AppointmentApiService(Dio dio, {String? baseUrl}) =
      _AppointmentApiService;

  @POST(ApiConst.appointments)
  Future<AppointmentResponse> bookAppointment(
    @Body() AppointmentRequestBody body,
  );

  @GET(ApiConst.appointments)
  Future<AppointmentListResponse> getAppointments();

  @GET("${ApiConst.appointments}/{id}")
  Future<AppointmentResponse> getAppointmentById(@Path("id") int id);

  @PUT("${ApiConst.appointments}/{id}")
  Future<AppointmentResponse> updateAppointment(
    @Path("id") int id,
    @Body() AppointmentRequestBody body,
  );
}
