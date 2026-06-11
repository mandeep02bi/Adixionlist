import 'package:freezed_annotation/freezed_annotation.dart';

part 'records_state.freezed.dart';

@freezed
class RecordsState<T> with _$RecordsState<T> {
  const factory RecordsState.initial() = _Initial;
  const factory RecordsState.loading() = Loading;
  const factory RecordsState.success(T data) = Success<T>;
  const factory RecordsState.error({required String error}) = Error;
}
