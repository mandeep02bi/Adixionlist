import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 60.h),
        // Logo
        Image.asset(
          'assets/images/logo/logo.png',
          height: 80.h,
        ),
        SizedBox(height: 12.h),
        Text(
          'Welcome Back',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Sign in to continue',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 13.sp,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
