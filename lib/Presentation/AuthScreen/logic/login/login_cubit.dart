import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Core/helper/token_storage_service.dart';
import 'package:doctor/Presentation/AuthScreen/data/models/login_request_body.dart';
import 'package:doctor/Presentation/AuthScreen/data/repo/login_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor/Presentation/AuthScreen/logic/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;
  final TokenStorageService tokenStorageService;
  
  LoginCubit({
    required this.loginRepo,
    required this.tokenStorageService,
  }) : super(const LoginState.initial());

  void emitLoginStates(LoginRequestBody requestBody) async {
    emit(const LoginState.loginLoading());
    final response = await loginRepo.login(requestBody);
    
    response.when(
      error: (error) {
        emit(LoginState.loginError(message: error.failure.message));
      },
      success: (loginResponse) async {
        // Save tokens and user info if login is successful
        if (loginResponse.data != null) {
          final data = loginResponse.data!;
          
          // Save tokens
          if (data.accessToken != null && data.refreshToken != null) {
            await tokenStorageService.saveTokens(
              accessToken: data.accessToken!,
              refreshToken: data.refreshToken!,
            );
          }
          
          // Save user info
          if (data.user != null) {
            await tokenStorageService.saveUserInfo(
              email: data.user!.email,
              role: data.user!.role,
              userCode: data.user!.userCode,
              firstName: data.user!.firstName,
              lastName: data.user!.lastName,
            );
          }
        }
        
        emit(LoginState.loginSuccess(loginResponse));
      },
    );
  }
}
