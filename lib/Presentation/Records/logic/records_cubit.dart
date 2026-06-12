import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Presentation/Records/data/repo/records_repo.dart';
import 'package:doctor/Presentation/Records/logic/records_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordsCubit extends Cubit<RecordsState> {
  final RecordsRepo recordsRepo;

  RecordsCubit({required this.recordsRepo}) : super(const RecordsState.initial());

  void getRecords(String patientCode, {String? search}) async {
    emit(const RecordsState.loading());
    final response = await recordsRepo.getRecords(patientCode, search: search);

    response.when(
      success: (data) {
        emit(RecordsState.success(data));
      },
      error: (error) {
        emit(RecordsState.error(error: error.failure.message));
      },
    );
  }


}
