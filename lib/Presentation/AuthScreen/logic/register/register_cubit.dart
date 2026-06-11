import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Presentation/AuthScreen/data/models/register_request_body.dart';
import 'package:doctor/Presentation/AuthScreen/data/repo/register_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor/Presentation/AuthScreen/logic/register/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo registerRepo;
  RegisterCubit({required this.registerRepo})
    : super(const RegisterState.initial());

  void emitRegisterStates(RegisterRequestBody requestBody) async {
    emit(const RegisterState.registerLoading());
    final response = await registerRepo.register(requestBody);
    response.when(
      error: (error) {
        emit(RegisterState.registerError(message: error.failure.message ));
      },
      success: (registerResponse) {
        emit(RegisterState.registerSuccess(registerResponse));
      },
    );
  }
}
