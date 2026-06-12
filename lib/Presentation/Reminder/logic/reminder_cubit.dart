import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Presentation/Reminder/data/models/reminder_request_body.dart';
import 'package:doctor/Presentation/Reminder/data/repo/reminder_repo.dart';
import 'package:doctor/Presentation/Reminder/logic/reminder_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReminderCubit extends Cubit<ReminderState> {
  final ReminderRepo reminderRepo;

  ReminderCubit({required this.reminderRepo}) : super(const ReminderState.initial());

  void createReminder(ReminderRequestBody body) async {
    emit(const ReminderState.loading());
    final response = await reminderRepo.createReminder(body);

    response.when(
      success: (data) {
        emit(ReminderState.success(data));

      },
      error: (error) {
        emit(ReminderState.error(error: error.failure.message));
      },
    );
  }

  void getReminders({String? patientCode, String? reminderType}) async {
    emit(const ReminderState.loading());
    final response = await reminderRepo.getReminders(
      patientCode: patientCode,
      reminderType: reminderType,
    );

    response.when(
      success: (data) {
        emit(ReminderState.success(data));
      },
      error: (error) {
        emit(ReminderState.error(error: error.failure.message));
      },
    );
  }


  Future<void> updateReminder({
    required int id,
    required ReminderRequestBody body,
  }) async {
    emit(const ReminderState.loading());

    final result = await reminderRepo.updateReminder(
      id: id,
      body: body.toJson(),
    );

    result.when(
      success: (data) {
        emit(ReminderState.success(data));
      },
      error: (error) {
        emit(
          ReminderState.error(
            error: error.failure.message,
          ),
        );
      },
    );
  }

  void deleteReminder({
    required int id,
    required String patientCode,
  }) async {

    emit(const ReminderState.loading());

    final response =
    await reminderRepo.deleteReminder(id);

    response.when(
      success: (data) {
        getReminders(patientCode: patientCode);
      },
      error: (error) {
        emit(
          ReminderState.error(
            error: error.failure.message,
          ),
        );
      },
    );
  }
}
