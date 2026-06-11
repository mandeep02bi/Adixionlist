import 'package:doctor/Presentation/HomeScreen/doctor_home_sc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'error_handler.dart';
import 'api_erro_model.dart';

class NetworkErrorNavigator {
  static bool _isShowingError = false;

  /// Handle network errors globally and navigate to home if needed
  static void handleNetworkError(
    BuildContext? context,
    ApiErroModel error, {
    bool navigateToHome = true,
    bool showSnackbar = true,
  }) {
    // Check if it's a network-related error
    final isNetworkError = _isNetworkError(error.statusCode);

    if (isNetworkError && navigateToHome && !_isShowingError) {
      _isShowingError = true;

      // Show error message
      if (showSnackbar && context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message),
            backgroundColor: Colors.red.shade600,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }

      // Navigate to home page after a short delay
      Future.delayed(const Duration(milliseconds: 500), () {
        _isShowingError = false;
        
        // Using GetX navigation
        Get.offAll(() => const Doctorhomesc());
      });
    } else if (showSnackbar && context != null) {
      // Show error message for non-network errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
          backgroundColor: Colors.red.shade600,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  /// Check if the error is network-related
  static bool _isNetworkError(int statusCode) {
    return statusCode == ResponseCode.CONNECT_TIMEOUT ||
        statusCode == ResponseCode.RECIEVE_TIMEOUT ||
        statusCode == ResponseCode.SEND_TIMEOUT ||
        statusCode == ResponseCode.NO_INTERNET_CONNECTION ||
        statusCode == ResponseCode.DEFAULT;
  }

  /// Show a dialog for network errors with retry option
  static void showNetworkErrorDialog(
    BuildContext context, {
    required VoidCallback onRetry,
    VoidCallback? onGoHome,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.wifi_off, color: Colors.red.shade600),
            const SizedBox(width: 10),
            const Text('Network Error'),
          ],
        ),
        content: const Text(
          'Unable to connect to the server. Please check your internet connection.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onGoHome != null) {
                onGoHome();
              } else {
                Get.offAll(() => const Doctorhomesc());
              }
            },
            child: const Text('Go to Home'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onRetry();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F6E56),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
