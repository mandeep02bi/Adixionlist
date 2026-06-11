// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:doctor/Core/services/auth_service.dart';

// // ── Events ─────────────────────────────────────────────────────────────────

// abstract class ForgotPasswordEvent {}

// class ForgotPasswordToggleObscure extends ForgotPasswordEvent {}

// class ForgotPasswordSubmitted extends ForgotPasswordEvent {
//   final String email;
//   ForgotPasswordSubmitted(this.email);
// }

// class ForgotPasswordOtpSubmitted extends ForgotPasswordEvent {
//   final String otp;
//   ForgotPasswordOtpSubmitted(this.otp);
// }

// class ForgotPasswordResetSubmitted extends ForgotPasswordEvent {
//   final String newPassword;
//   ForgotPasswordResetSubmitted(this.newPassword);
// }

// // ── State ──────────────────────────────────────────────────────────────────

// enum ForgotPasswordStep { email, otp, newPassword }

// enum ForgotPasswordStatus { initial, loading, success, failure }

// class ForgotPasswordState {
//   final ForgotPasswordStep step;
//   final ForgotPasswordStatus status;
//   final String email; // kept to display on OTP screen
//   final bool obscureText;
//   final String? errorMessage;
//   final String? successMessage;

//   const ForgotPasswordState({
//     this.step = ForgotPasswordStep.email,
//     this.status = ForgotPasswordStatus.initial,
//     this.email = '',
//     this.obscureText = true,
//     this.errorMessage,
//     this.successMessage,
//   });

//   ForgotPasswordState copyWith({
//     ForgotPasswordStep? step,
//     ForgotPasswordStatus? status,
//     String? email,
//     bool? obscureText,
//     String? errorMessage,
//     String? successMessage,
//   }) {
//     return ForgotPasswordState(
//       step: step ?? this.step,
//       status: status ?? this.status,
//       email: email ?? this.email,
//       obscureText: obscureText ?? this.obscureText,
//       errorMessage: errorMessage,
//       successMessage: successMessage,
//     );
//   }
// }

// // ── BLoC ───────────────────────────────────────────────────────────────────

// class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
//   ForgotPasswordBloc() : super(const ForgotPasswordState()) {
//     on<ForgotPasswordToggleObscure>((e, emit) =>
//         emit(state.copyWith(obscureText: !state.obscureText)));
//     on<ForgotPasswordSubmitted>(_onSendOtp);
//     on<ForgotPasswordOtpSubmitted>(_onVerifyOtp);
//     on<ForgotPasswordResetSubmitted>(_onResetPassword);
//   }

//   Future<void> _onSendOtp(
//       ForgotPasswordSubmitted event, Emitter<ForgotPasswordState> emit) async {
//     emit(state.copyWith(status: ForgotPasswordStatus.loading, errorMessage: null));
//     try {
//       final message = await AuthService.forgotPassword(event.email.trim());
//       emit(state.copyWith(
//         status: ForgotPasswordStatus.success,
//         step: ForgotPasswordStep.otp,
//         email: event.email.trim(),
//         successMessage: message,
//       ));
//     } on AuthException catch (e) {
//       emit(state.copyWith(status: ForgotPasswordStatus.failure, errorMessage: e.message));
//     } catch (_) {
//       emit(state.copyWith(
//         status: ForgotPasswordStatus.failure,
//         errorMessage: 'Something went wrong. Please try again.',
//       ));
//     }
//   }

//   Future<void> _onVerifyOtp(
//       ForgotPasswordOtpSubmitted event, Emitter<ForgotPasswordState> emit) async {
//     emit(state.copyWith(status: ForgotPasswordStatus.loading, errorMessage: null));
//     try {
//       final message = await AuthService.verifyOtp(
//         email: state.email,
//         otp: event.otp.trim(),
//       );
//       emit(state.copyWith(
//         status: ForgotPasswordStatus.success,
//         step: ForgotPasswordStep.newPassword,
//         successMessage: message,
//       ));
//     } on AuthException catch (e) {
//       emit(state.copyWith(status: ForgotPasswordStatus.failure, errorMessage: e.message));
//     } catch (_) {
//       emit(state.copyWith(
//         status: ForgotPasswordStatus.failure,
//         errorMessage: 'Something went wrong. Please try again.',
//       ));
//     }
//   }

//   Future<void> _onResetPassword(
//       ForgotPasswordResetSubmitted event, Emitter<ForgotPasswordState> emit) async {
//     emit(state.copyWith(status: ForgotPasswordStatus.loading, errorMessage: null));
//     try {
//       final message = await AuthService.resetPassword(
//         email: state.email,
//         newPassword: event.newPassword.trim(),
//       );
//       emit(state.copyWith(
//         status: ForgotPasswordStatus.success,
//         successMessage: message,
//       ));
//     } on AuthException catch (e) {
//       emit(state.copyWith(status: ForgotPasswordStatus.failure, errorMessage: e.message));
//     } catch (_) {
//       emit(state.copyWith(
//         status: ForgotPasswordStatus.failure,
//         errorMessage: 'Something went wrong. Please try again.',
//       ));
//     }
//   }
// }
