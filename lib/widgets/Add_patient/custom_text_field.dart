import 'package:doctor/core/Theme/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final String hint;
  final String? icon;
  final String? subText;

  final IconData? suffixIcon;
  final double? width;
  final double? height;
  final String? suffixIconPath;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Color? textColor;
  final Color? iconColor;
  final double? widthIcon;
  final double? heightIcon;

  final bool isDateField;
  final VoidCallback? onTap;
  final Color? fieldFillColor;
  final TextStyle? hintStyle;

  const CustomFormField({
    super.key,
    required this.label,
    required this.hint,
    this.icon,
    this.subText,
    this.suffixIcon,
    this.height,
    this.width,
    this.suffixIconPath,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textColor,
    this.iconColor,
    this.widthIcon,
    this.heightIcon,
    this.isDateField = false,
    this.onTap,
    this.fieldFillColor = const Color(0xFFF8FEFB),
    this.hintStyle,
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
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8.w,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: height?.h,
          width: width?.w,
          child: TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            readOnly: isDateField,
            onTap: onTap,
            cursorColor: primaryGreen,
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
                  ? Icon(
                      suffixIcon,
                      size: 20.r,
                      color: iconColor ?? Colors.black87,
                    )
                  : suffixIconPath != null
                      ? Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Image.asset(
                            suffixIconPath!,
                            width: widthIcon?.w,
                            height: heightIcon?.h,
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
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1.5,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

