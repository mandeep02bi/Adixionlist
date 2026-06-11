// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:doctor/Core/services/auth_service.dart';

// // ── Events ─────────────────────────────────────────────────────────────────

// abstract class SignupEvent {}

// class SignupRoleChanged extends SignupEvent {
//   final String role; // 'Doctor' or 'Staff'
//   SignupRoleChanged(this.role);
// }

// class SignupTogglePassword extends SignupEvent {}

// class SignupSubmitted extends SignupEvent {
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phone;
//   final String password;
//   SignupSubmitted({
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phone,
//     required this.password,
//   });
// }

// // ── State ──────────────────────────────────────────────────────────────────

// enum SignupStatus { initial, loading, success, failure }

// class SignupState {
//   final String role;
//   final bool obscureText;
//   final SignupStatus status;
//   final String? errorMessage;
//   final String? successMessage;

//   const SignupState({
//     this.role = 'Doctor',
//     this.obscureText = true,
//     this.status = SignupStatus.initial,
//     this.errorMessage,
//     this.successMessage,
//   });

//   SignupState copyWith({
//     String? role,
//     bool? obscureText,
//     SignupStatus? status,
//     String? errorMessage,
//     String? successMessage,
//   }) {
//     return SignupState(
//       role: role ?? this.role,
//       obscureText: obscureText ?? this.obscureText,
//       status: status ?? this.status,
//       errorMessage: errorMessage,
//       successMessage: successMessage,
//     );
//   }
// }

// // ── BLoC ───────────────────────────────────────────────────────────────────

// class SignupBloc extends Bloc<SignupEvent, SignupState> {
//   SignupBloc() : super(const SignupState()) {
//     on<SignupRoleChanged>((e, emit) =>
//         emit(state.copyWith(role: e.role, status: SignupStatus.initial)));
//     on<SignupTogglePassword>((e, emit) =>
//         emit(state.copyWith(obscureText: !state.obscureText)));
//     on<SignupSubmitted>(_onSubmit);
//   }

//   Future<void> _onSubmit(SignupSubmitted event, Emitter<SignupState> emit) async {
//     emit(state.copyWith(status: SignupStatus.loading, errorMessage: null));
//     try {
//       final message = await AuthService.register(
//         firstName: event.firstName.trim(),
//         lastName: event.lastName.trim(),
//         email: event.email.trim(),
//         password: event.password.trim(),
//         role: state.role,
//         phone: event.phone.trim(),
//       );
//       emit(state.copyWith(status: SignupStatus.success, successMessage: message));
//     } on AuthException catch (e) {
//       emit(state.copyWith(status: SignupStatus.failure, errorMessage: e.message));
//     } catch (_) {
//       emit(state.copyWith(
//         status: SignupStatus.failure,
//         errorMessage: 'Something went wrong. Please try again.',
//       ));
//     }
//   }
// }
