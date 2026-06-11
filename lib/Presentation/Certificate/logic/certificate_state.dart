import 'package:freezed_annotation/freezed_annotation.dart';

part 'certificate_state.freezed.dart';

@freezed
class CertificateState<T> with _$CertificateState<T> {
  const factory CertificateState.initial() = _Initial;
  const factory CertificateState.loading() = Loading;
  const factory CertificateState.success(T data) = Success<T>;
  const factory CertificateState.error({required String error}) = Error;
}
