import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Presentation/Appointment/data/models/appointment_request_body.dart';
import 'package:doctor/Presentation/Appointment/data/repo/appointment_repo.dart';
import 'package:doctor/Presentation/Appointment/logic/appointment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepo appointmentRepo;

  AppointmentCubit({required this.appointmentRepo})
    : super(const AppointmentState.initial());

  void bookAppointment(AppointmentRequestBody body) async {
    emit(const AppointmentState.loading());
    final response = await appointmentRepo.bookAppointment(body);
    if (isClosed) return;

    response.when(
      success: (data) {
        emit(AppointmentState.success(data));
      },
      error: (error) {
        emit(AppointmentState.error(error: error.failure.message));
      },
    );
  }

  Future<void> getAppointments() async {
    emit(const AppointmentState.loading());

    final result = await appointmentRepo.getAppointments();

    if (isClosed) return; // ADD THIS

    result.when(
      success: (data) {
        print("TOTAL APPOINTMENTS => ${data.data.length}");

        emit(AppointmentState.listSuccess(data.data));
      },
      error: (error) {
        print("API ERROR => ${error.failure.message}");

        emit(AppointmentState.error(error: error.failure.message));
      },
    );
  }

  Future<void> updateAppointment(int id, AppointmentRequestBody body) async {
    emit(const AppointmentState.loading());

    final result = await appointmentRepo.updateAppointment(id, body);

    if (isClosed) return;

    result.when(
      success: (data) {
        emit(AppointmentState.updateSuccess(data.message));
      },
      error: (error) {
        emit(AppointmentState.error(error: error.failure.message));
      },
    );
  }
}
