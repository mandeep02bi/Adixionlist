import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:doctor/Core/Theme/color_app.dart';
import 'package:doctor/Presentation/AuthScreen/ForgotPasswordSC.dart';

class ForgotPasswordLink extends StatelessWidget {
  const ForgotPasswordLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => Get.to(() => const ForgotPasswordSC()),
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: ColorApp.textColor,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
