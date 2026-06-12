import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Presentation/Instruction/data/models/instruction_request_body.dart';
import 'package:doctor/Presentation/Instruction/data/repo/instruction_repo.dart';
import 'package:doctor/Presentation/Instruction/logic/instruction_state.dart';

class InstructionCubit extends Cubit<InstructionState> {
  final InstructionRepo instructionRepo;

  InstructionCubit({required this.instructionRepo})
    : super(const InstructionState.initial());

  // CREATE INSTRUCTION
  void createInstruction(InstructionRequestBody body) async {
    emit(const InstructionState.loading());

    final response = await instructionRepo.createInstruction(body);

    response.when(
      success: (data) {
        emit(InstructionState.success(data));
      },
      error: (error) {
        emit(InstructionState.error(error: error.failure.message));
      },
    );
  }

  // GET INSTRUCTIONS
  void getInstructions(String? patientCode, {String? sort}) async {
    emit(const InstructionState.loading());

    final response = await instructionRepo.getInstructions(
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
  }

// UPDATE INSTRUCTION
  void updateInstruction(
      int id,
      InstructionRequestBody body,
      ) async {
    emit(const InstructionState.loading());

    final response = await instructionRepo.updateInstruction(
      id,
      body,
    );

    response.when(
      success: (data) {
        if (!isClosed) {
          emit(InstructionState.success(data));
        }
      },
      error: (error) {
        if (!isClosed) {
          emit(
            InstructionState.error(
              error: error.failure.message,
            ),
          );
        }
      },
    );
  }

// DELETE INSTRUCTION
  void deleteInstruction(
      int id,
      String patientCode,
      ) async {
    emit(const InstructionState.loading());

    final response = await instructionRepo.deleteInstruction(id);

    response.when(
      success: (_) {
        getInstructions(patientCode);
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
