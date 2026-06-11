import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  final FlutterSecureStorage _secureStorage;

  TokenStorageService(this._secureStorage);

  // Keys for storing tokens
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userEmailKey = 'user_email';
  static const String _userRoleKey = 'user_role';
  static const String _userCodeKey = 'user_code';
  static const String _userFirstNameKey = 'user_first_name';
  static const String _userLastNameKey = 'user_last_name';

  // Save tokens
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  // Save user info
  Future<void> saveUserInfo({
    required String email,
    required String role,
    String? userCode,
    String? firstName,
    String? lastName,
  }) async {
    await _secureStorage.write(key: _userEmailKey, value: email);
    await _secureStorage.write(key: _userRoleKey, value: role);
    if (userCode != null) {
      await _secureStorage.write(key: _userCodeKey, value: userCode);
    }
    if (firstName != null) {
      await _secureStorage.write(key: _userFirstNameKey, value: firstName);
    }
    if (lastName != null) {
      await _secureStorage.write(key: _userLastNameKey, value: lastName);
    }
  }

  // Get access token
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  // Get refresh token
  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  // Get user email
  Future<String?> getUserEmail() async {
    return await _secureStorage.read(key: _userEmailKey);
  }

  // Get user role
  Future<String?> getUserRole() async {
    return await _secureStorage.read(key: _userRoleKey);
  }

  // Get user code
  Future<String?> getUserCode() async {
    return await _secureStorage.read(key: _userCodeKey);
  }

  // Get user first name
  Future<String?> getUserFirstName() async {
    return await _secureStorage.read(key: _userFirstNameKey);
  }

  // Get user last name
  Future<String?> getUserLastName() async {
    return await _secureStorage.read(key: _userLastNameKey);
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final accessToken = await getAccessToken();
    return accessToken != null && accessToken.isNotEmpty;
  }

  // Clear all tokens and user data (logout)
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }

  // Clear only tokens (keep user info)
  Future<void> clearTokens() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }
}
