import 'package:freezed_annotation/freezed_annotation.dart';

part 'instruction_state.freezed.dart';

@freezed
class InstructionState<T> with _$InstructionState<T> {
  const factory InstructionState.initial() = _Initial;

  const factory InstructionState.loading() = Loading;

  const factory InstructionState.success(T data) = Success<T>;

  const factory InstructionState.error({required String error}) = Error<T>;
}
