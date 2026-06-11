import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_state.freezed.dart';

@freezed
class PatientListState<T> with _$PatientListState<T> {
  const factory PatientListState.initial() = _Initial;
  const factory PatientListState.loading() = Loading;
  const factory PatientListState.success(T data) = Success<T>;
  const factory PatientListState.error({required String error}) = Error;
}
