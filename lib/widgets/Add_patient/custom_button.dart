import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final String? subText;
  final IconData? icon;
  final double? widthicon;
  final double? heighticon;
  final Color? buttonColor;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final TextStyle? subTextStyle;
  final Border? border;
  final String? assetIcon;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.subText,
    this.assetIcon,
    this.icon,
    this.buttonColor,
    this.widthicon,
    this.heighticon,
    this.height,
    this.width,
    this.border,
    this.textStyle,
    this.subTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: width?.w ?? double.infinity,
          height: height?.h ?? 60.h,
          decoration: BoxDecoration(
            color: buttonColor ?? const Color(0xFF8D34B0),
            borderRadius: BorderRadius.circular(15.r),
            border: border,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (assetIcon != null) ...[
                Image.asset(
                  assetIcon!,
                  width: widthicon?.w ?? 16.w,
                  height: heighticon?.h ?? 15.83.h,
                ),
                SizedBox(width: 10.w),
              ],
              if (subText != null)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: textStyle ??
                          TextStyle(
                            color: const Color(0xFFEDEDED),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      subText!,
                      style: subTextStyle ??
                          TextStyle(
                            color: const Color(0xFFEDEDED),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                )
              else
                Text(
                  text,
                  style: textStyle ??
                      TextStyle(
                        color: const Color(0xFFEDEDED),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              if (icon != null) ...[
                SizedBox(width: 10.w),
                Icon(icon, color: Colors.white, size: 25.r),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

