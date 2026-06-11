import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final bool status;
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String message;
  final LoginUserData? data;

  LoginResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class LoginUserData {
  final UserInfo? user;
  final String? accessToken;
  final String? refreshToken;

  LoginUserData({
    this.user,
    this.accessToken,
    this.refreshToken,
  });

  factory LoginUserData.fromJson(Map<String, dynamic> json) =>
      _$LoginUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserDataToJson(this);
}

@JsonSerializable()
class UserInfo {
  @JsonKey(name: 'user_code')
  final String? userCode;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String email;
  final String role;

  UserInfo({
    this.userCode,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
