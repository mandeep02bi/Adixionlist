// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:doctor/Core/services/auth_service.dart';
// import 'package:doctor/Data/model/user_model.dart';

// // ── Events ─────────────────────────────────────────────────────────────────

// abstract class LoginEvent {}

// class LoadLogin extends LoginEvent {}

// class TogglePassword extends LoginEvent {}

// class LoginSubmitted extends LoginEvent {
//   final String email;
//   final String password;
//   LoginSubmitted({required this.email, required this.password});
// }

// // ── State ──────────────────────────────────────────────────────────────────

// enum LoginStatus { initial, loading, success, failure }

// class LoginState {
//   final bool isLoading;
//   final bool obscureText;
//   final LoginStatus status;
//   final String? errorMessage;
//   final UserModel? user;

//   const LoginState({
//     this.isLoading = true,
//     this.obscureText = true,
//     this.status = LoginStatus.initial,
//     this.errorMessage,
//     this.user,
//   });

//   LoginState copyWith({
//     bool? isLoading,
//     bool? obscureText,
//     LoginStatus? status,
//     String? errorMessage,
//     UserModel? user,
//   }) {
//     return LoginState(
//       isLoading: isLoading ?? this.isLoading,
//       obscureText: obscureText ?? this.obscureText,
//       status: status ?? this.status,
//       errorMessage: errorMessage,
//       user: user ?? this.user,
//     );
//   }
// }

// // ── BLoC ───────────────────────────────────────────────────────────────────

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   LoginBloc() : super(const LoginState()) {
//     on<LoadLogin>(_onLoad);
//     on<TogglePassword>(_onTogglePassword);
//     on<LoginSubmitted>(_onSubmit);
//   }

//   Future<void> _onLoad(LoadLogin event, Emitter<LoginState> emit) async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     emit(state.copyWith(isLoading: false));
//   }

//   void _onTogglePassword(TogglePassword event, Emitter<LoginState> emit) {
//     emit(state.copyWith(obscureText: !state.obscureText));
//   }

//   Future<void> _onSubmit(LoginSubmitted event, Emitter<LoginState> emit) async {
//     emit(state.copyWith(status: LoginStatus.loading, errorMessage: null));
//     try {
//       final user = await AuthService.login(
//         email: event.email.trim(),
//         password: event.password.trim(),
//       );
//       emit(state.copyWith(status: LoginStatus.success, user: user));
//     } on AuthException catch (e) {
//       emit(state.copyWith(status: LoginStatus.failure, errorMessage: e.message));
//     } catch (_) {
//       emit(state.copyWith(
//         status: LoginStatus.failure,
//         errorMessage: 'Something went wrong. Please try again.',
//       ));
//     }
//   }
// }
