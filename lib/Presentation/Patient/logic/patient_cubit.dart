import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Presentation/Patient/data/repo/patient_repo.dart';
import 'package:doctor/Presentation/Patient/logic/patient_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientListCubit extends Cubit<PatientListState> {
  final PatientRepo patientRepo;

  PatientListCubit({required this.patientRepo}) : super(const PatientListState.initial());

  void getPatients() async {
    emit(const PatientListState.loading());
    final response = await patientRepo.getPatients();

    response.when(
      success: (data) {
        emit(PatientListState.success(data));
      },
      error: (error) {
        emit(PatientListState.error(error: error.failure.message));
      },
    );
  }
}
