import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final String? icon;
  final double? widthicon;
  final double? heighticon;
  final Color? buttonColor;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final Border? border;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.buttonColor,
    this.widthicon,
    this.heighticon,
    this.height,
    this.width,
    this.border,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: width?.w ?? 400.w,
          height: height?.h ?? 60.h,
          decoration: BoxDecoration(
            color: buttonColor ?? const Color(0xFF8D34B0),
            borderRadius: BorderRadius.circular(20.r),
            border: border,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Image.asset(
                  icon!,
                  width: widthicon?.w ?? 16.w,
                  height: heighticon?.h ?? 15.83.h,
                ),
                SizedBox(width: 10.w),
              ],
              Text(
                text,
                style: textStyle ??
                    TextStyle(
                      color: const Color(0xFFEDEDED),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

