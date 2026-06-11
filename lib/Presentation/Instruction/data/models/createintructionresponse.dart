class CreateInstructionResponse {
  final bool status;
  final int statusCode;
  final String message;
  final int id;

  CreateInstructionResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.id,
  });

  factory CreateInstructionResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return CreateInstructionResponse(
      status: json["status"] ?? false,
      statusCode: json["status_code"] ?? 0,
      message: json["message"] ?? "",
      id: json["data"]?["id"] ?? 0,
    );
  }
}