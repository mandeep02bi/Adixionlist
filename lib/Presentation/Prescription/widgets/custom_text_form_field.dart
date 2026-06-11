import 'package:doctor/core/Theme/color_app.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
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
  final Color? borderColor;
  final Color? focusedBorderColor;
  final double? width;
  final double? height; 
  const CustomTextFormField({
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
    this.borderColor,
    this.focusedBorderColor,
    this.width,
    this.height,
  });

  static const Color primaryGreen = Color(0xFF0F6E56);
  static const Color borderSideColor = Color(0xFFE0E0E0);

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = borderColor ?? borderSideColor;
    final effectiveFocusedBorderColor = focusedBorderColor ?? primaryGreen;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label.toUpperCase(),
            style:
                lableStyle ??
                TextStyle(
                  fontSize: 14,
                  color: ColorApp.labelColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
          ),
          const SizedBox(height: 6),
        ],

        SizedBox(
          width: width,
          height: height,
          child: TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            cursorColor: ColorApp.textColor,
            style: TextStyle(
              color: textColor ?? ColorApp.textColor,
              fontSize: 14,
            ),
            maxLines: keyboardType == TextInputType.multiline ? 3 : 1,
            expands: height != null && keyboardType != TextInputType.multiline
                ? false
                : false,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:
                  hintStyle ??
                  TextStyle(fontSize: 14, color: ColorApp.hintColor),
              prefixIcon: icon != null
                  ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        icon!,
                        width: widthIcon,
                        height: heightIcon,
                        color: iconColor,
                        fit: BoxFit.contain,
                      ),
                    )
                  : null,
              suffixIcon: suffixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        suffixIcon!,
                        width: widthIcon,
                        height: heightIcon,
                        fit: BoxFit.contain,
                      ),
                    )
                  : null,
              filled: true,
              fillColor: fieldFillColor ?? Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: effectiveBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: effectiveFocusedBorderColor,
                  width: 1.2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.redAccent, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1.5,
                ),
              ),
              contentPadding: height != null
                  ? EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: ((height! - 14) / 2).clamp(0, 20),
                    )
                  : const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}
