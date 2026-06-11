import 'package:flutter/material.dart';
import 'package:doctor/Core/widgets/custom_button.dart';

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: isLoading ? null : onPressed,
      text: isLoading ? 'Signing in...' : 'Login',
    );
  }
}
