import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Core/networking/error_handler.dart';

import 'package:doctor/Presentation/Instruction/data/api/instruction_api_service.dart';

import 'package:doctor/Presentation/Instruction/data/models/instruction_request_body.dart';

import 'package:doctor/Presentation/Instruction/data/models/instruction_response.dart';

class InstructionRepo {
  final InstructionApiService instructionApiService;

  const InstructionRepo({required this.instructionApiService});

  Future<ApiResult<InstructionResponse>> createInstruction(
    InstructionRequestBody body,
  ) async {
    try {
      final response = await instructionApiService.createInstruction(body);

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<InstructionListResponse>> getInstructions(
    String? patientCode, {
    String? sort,
  }) async {
    try {
      final response = await instructionApiService.getInstructions(
        patientCode,
        sort,
      );

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }
}
