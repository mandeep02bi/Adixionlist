class UserModel {
  final String userCode;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String? phone;
  final String? platform;
  final String? deviceType;

  UserModel({
    required this.userCode,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    this.phone,
    this.platform,
    this.deviceType,
  });

  String get fullName => '$firstName $lastName';

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userCode: json['user_code'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      phone: json['phone'],
      platform: json['platform'],
      deviceType: json['device_type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'user_code': userCode,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'role': role,
        'phone': phone,
        'platform': platform,
        'device_type': deviceType,
      };
}
