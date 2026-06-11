import 'package:doctor/Core/theme/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormFieldCore extends StatelessWidget {
  final String label;
  final String hint;
  final String? icon;
  final String? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Color? textColor;
  final Color? iconColor;
  final double? widthIcon;
  final double? heightIcon;
  final Color? fieldFillColor;
  final TextStyle? hintStyle;
  final TextStyle? lableStyle;

  const CustomTextFormFieldCore({
    super.key,
    required this.label,
    required this.hint,
    this.icon,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textColor,
    this.iconColor,
    this.widthIcon,
    this.heightIcon,
    this.fieldFillColor,
    this.hintStyle,
    this.lableStyle,
  });

  static const Color primaryGreen = Color(0xFF0F6E56);
  static const Color borderSideColor = Color(0xFFE0E0E0);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: lableStyle ??
              TextStyle(
                fontSize: 14.sp,
                color: ColorApp.labelColor,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8.w,
              ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          cursorColor: ColorApp.textColor,
          maxLines: keyboardType == TextInputType.multiline ? 3 : 1,
          style: TextStyle(fontSize: 14.sp),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: hintStyle ??
                TextStyle(fontSize: 14.sp, color: ColorApp.hintColor),
            prefixIcon: icon != null
                ? Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Image.asset(
                      icon!,
                      width: widthIcon?.w,
                      height: heightIcon?.h,
                      fit: BoxFit.contain,
                    ),
                  )
                : null,
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Image.asset(
                      suffixIcon!,
                      width: widthIcon?.w,
                      height: heightIcon?.h,
                      fit: BoxFit.contain,
                    ),
                  )
                : null,
            filled: true,
            fillColor: fieldFillColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: borderSideColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: primaryGreen, width: 1.2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
          ),
        ),
      ],
    );
  }
}

