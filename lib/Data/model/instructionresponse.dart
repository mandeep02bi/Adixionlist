import 'package:doctor/Presentation/Instruction/data/models/instruction_response.dart';


class InstructionResponse {
  final bool status;
  final int statusCode;
  final String message;
  final List<InstructionModel> data;

  InstructionResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory InstructionResponse.fromJson(Map<String, dynamic> json) {
    return InstructionResponse(
      status: json['status'],
      statusCode: json['status_code'],
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => InstructionModel.fromJson(e))
          .toList(),
    );
  }
}