import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  final bool status;
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String message;
  final RegisterUserData? data;

  RegisterResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

@JsonSerializable()
class RegisterUserData {
  @JsonKey(name: 'user_code')
  final String? userCode;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String email;
  final String role;

  RegisterUserData({
    this.userCode,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
  });

  factory RegisterUserData.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterUserDataToJson(this);
}
