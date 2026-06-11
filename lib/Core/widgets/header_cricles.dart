import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderBackgroundCircles extends StatelessWidget {
  const HeaderBackgroundCircles({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// LEFT CIRCLE
        Positioned(
          left: -55.w,
          top: -60.h,
          child: Container(
            width: 220.w,
            height: 220.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF61CEFF).withOpacity(.18),
            ),
          ),
        ),

        /// RIGHT CIRCLE
        Positioned(
          right: -50.w,
          top: -30.h,
          child: Container(
            width: 180.w,
            height: 180.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(.12),
            ),
          ),
        ),
      ],
    );
  }
}
