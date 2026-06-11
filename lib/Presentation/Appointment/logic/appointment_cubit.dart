import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Presentation/Appointment/data/models/appointment_request_body.dart';
import 'package:doctor/Presentation/Appointment/data/repo/appointment_repo.dart';
import 'package:doctor/Presentation/Appointment/logic/appointment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepo appointmentRepo;

  AppointmentCubit({required this.appointmentRepo}) : super(const AppointmentState.initial());

  void bookAppointment(AppointmentRequestBody body) async {
    emit(const AppointmentState.loading());
    final response = await appointmentRepo.bookAppointment(body);

    response.when(
      success: (data) {
        emit(AppointmentState.success(data));
      },
      error: (error) {
        emit(AppointmentState.error(error: error.failure.message));
      },
    );
  }
}
