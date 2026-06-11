import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_request_body.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_response.dart';
import 'package:doctor/Presentation/Patient/data/repo/patient_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AddPatientEvent {}

class SubmitPatient extends AddPatientEvent {
  final PatientRequestBody requestBody;
  SubmitPatient(this.requestBody);
}

abstract class AddPatientState {}

class AddPatientInitial extends AddPatientState {}
class AddPatientLoading extends AddPatientState {}
class AddPatientSuccess extends AddPatientState {
  final PatientResponse response;
  AddPatientSuccess(this.response);
}
class AddPatientError extends AddPatientState {
  final String message;
  final int statusCode;
  AddPatientError(this.message, {this.statusCode = -7});
}

class AddPatientBloc extends Bloc<AddPatientEvent, AddPatientState> {
  final PatientRepo patientRepo;

  AddPatientBloc({required this.patientRepo}) : super(AddPatientInitial()) {
    on<SubmitPatient>((event, emit) async {
      emit(AddPatientLoading());

      final result = await patientRepo.addPatient(event.requestBody);

      result.when(
        success: (response) {
          emit(AddPatientSuccess(response));
        },
        error: (error) {
          emit(AddPatientError(
            error.failure.message,
            statusCode: error.failure.statusCode,
          ));
        },
      );
    });
  }
}