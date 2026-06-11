import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder_state.freezed.dart';

@freezed
class ReminderState<T> with _$ReminderState<T> {
  const factory ReminderState.initial() = _Initial;
  const factory ReminderState.loading() = Loading;
  const factory ReminderState.success(T data) = Success<T>;
  const factory ReminderState.error({required String error}) = Error;
}
