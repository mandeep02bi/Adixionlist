import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_state.freezed.dart';

@freezed
class AppointmentState<T> with _$AppointmentState<T> {
  const factory AppointmentState.initial() = _Initial;
  const factory AppointmentState.loading() = Loading;
  const factory AppointmentState.success(T data) = Success<T>;
  const factory AppointmentState.error({required String error}) = Error;
}
