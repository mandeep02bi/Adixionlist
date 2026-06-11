import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSectionTitle extends StatelessWidget {
  final String? icon;
  final String title;
  final double? widthIcon;
  final double? heightIcon;
  final TextStyle? textStyle;

  const CustomSectionTitle({
    super.key,
    this.icon,
    required this.title,
    this.widthIcon,
    this.heightIcon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Image.asset(icon!, width: widthIcon?.w, height: heightIcon?.h),
          ),
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

