import 'package:dio/dio.dart';
import 'package:doctor/Core/networking/api_const.dart';
import 'package:doctor/Presentation/Instruction/data/models/instruction_request_body.dart';
import 'package:doctor/Presentation/Instruction/data/models/instruction_response.dart';
import 'package:retrofit/retrofit.dart';

part 'instruction_api_service.g.dart';

@RestApi(baseUrl: ApiConst.baseUrl)
abstract class InstructionApiService {
  factory InstructionApiService(Dio dio, {String? baseUrl}) = _InstructionApiService;

  @POST(ApiConst.instructions)
  Future<InstructionResponse> createInstruction(
    @Body() InstructionRequestBody body,
  );

  @GET(ApiConst.instructions)
  Future<InstructionListResponse> getInstructions(
    @Query('patient_code') String? patientCode,
    @Query('sort') String? sort,
  );
}
