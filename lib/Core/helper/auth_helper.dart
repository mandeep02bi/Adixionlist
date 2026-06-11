import 'package:doctor/Core/helper/token_storage_service.dart';

/// Helper class for authentication-related operations
class AuthHelper {
  final TokenStorageService _tokenStorageService;

  AuthHelper(this._tokenStorageService);

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    return await _tokenStorageService.isLoggedIn();
  }

  /// Get the current access token for API requests
  Future<String?> getAccessToken() async {
    return await _tokenStorageService.getAccessToken();
  }

  /// Logout user by clearing all stored data
  Future<void> logout() async {
    await _tokenStorageService.clearAll();
  }

  /// Get user display name
  Future<String?> getUserDisplayName() async {
    final firstName = await _tokenStorageService.getUserFirstName();
    final lastName = await _tokenStorageService.getUserLastName();
    
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    return firstName ?? lastName;
  }
}
