import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSectionTitle extends StatelessWidget {
  final String icon;
  final String title;
  final double widthIcon;
  final double heightIcon;
  final TextStyle? textStyle;

  const CustomSectionTitle({
    super.key,
    required this.icon,
    required this.title,
    required this.widthIcon,
    required this.heightIcon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(icon, width: widthIcon.w, height: heightIcon.h),
        SizedBox(width: 10.w),
        Text(
          title,
          style: textStyle ??
              TextStyle(
                color: const Color(0xFF0F6E56),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

