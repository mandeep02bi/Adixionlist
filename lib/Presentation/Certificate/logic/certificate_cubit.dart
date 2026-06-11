import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Presentation/Certificate/data/models/certificate_request_body.dart';
import 'package:doctor/Presentation/Certificate/data/repo/certificate_repo.dart';
import 'package:doctor/Presentation/Certificate/logic/certificate_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CertificateCubit extends Cubit<CertificateState> {
  final CertificateRepo certificateRepo;

  CertificateCubit({required this.certificateRepo}) : super(const CertificateState.initial());

  void createCertificate(CertificateRequestBody body) async {
    emit(const CertificateState.loading());
    final response = await certificateRepo.createCertificate(body);

    response.when(
      success: (data) {
        emit(CertificateState.success(data));
      },
      error: (error) {
        emit(CertificateState.error(error: error.failure.message));
      },
    );
  }

  void getCertificates(String? patientCode, {String? sort}) async {
    emit(const CertificateState.loading());
    final response = await certificateRepo.getCertificates(patientCode, sort: sort);

    response.when(
      success: (data) {
        emit(CertificateState.success(data));
      },
      error: (error) {
        emit(CertificateState.error(error: error.failure.message));
      },
    );
  }
}
