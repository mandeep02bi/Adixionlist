import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Presentation/Instruction/data/repo/instruction_repo.dart';
import 'package:doctor/Presentation/Instruction/logic/instruction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/instruction_request_body.dart';

class InstructionCubit extends Cubit<InstructionState> {
  final InstructionRepo repository;

  InstructionCubit(this.repository) : super(const InstructionState.initial());

  Future<void> getInstructions(String? patientCode, {String? sort}) async {
    try {
      emit(const InstructionState.loading());

      final response = await repository.getInstructions(
        patientCode,
        sort: sort,
      );

      response.when(
        success: (data) {
          emit(InstructionState.success(data));
        },

        error: (error) {
          emit(InstructionState.error(error: error.failure.message));
        },
      );
    } catch (e) {
      emit(InstructionState.error(error: e.toString()));
    }
  }

  void updateInstruction(
      int id,
      InstructionRequestBody body,
      ) async {
    emit(const InstructionState.loading());

    final response = await repository.updateInstruction(id, body);

    response.when(
      success: (data) {
        emit(InstructionState.success(data));
      },
      error: (error) {
        emit(
          InstructionState.error(
            error: error.failure.message,
          ),
        );
      },
    );
  }

  void deleteInstruction(int id) async {
    emit(const InstructionState.loading());

    final response = await repository.deleteInstruction(id);

    response.when(
      success: (data) {
        emit(InstructionState.success(data));
      },
      error: (error) {
        emit(
          InstructionState.error(
            error: error.failure.message,
          ),
        );
      },
    );
  }

}
