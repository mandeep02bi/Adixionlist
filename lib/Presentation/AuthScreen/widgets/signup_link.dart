import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:doctor/Core/Theme/color_app.dart';
import 'package:doctor/Presentation/AuthScreen/Signup.dart';

class SignupLink extends StatelessWidget {
  const SignupLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.white70, fontSize: 13.sp),
        ),
        GestureDetector(
          onTap: () => Get.to(() => const SignupSC()),
          child: Text(
            'Join us',
            style: TextStyle(
              color: ColorApp.textColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
