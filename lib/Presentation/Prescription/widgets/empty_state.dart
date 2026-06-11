
import 'package:doctor/core/Theme/color_app.dart';
import 'package:doctor/Presentation/Prescription/widgets/border_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyState extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  const EmptyState({
    super.key,
    required this.icon,
    required this.subtitle,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0.r),
      child: DashedBorderContainer(
        child: Container(
          height: 154.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorApp.scaffoldColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icon, width: 40.w, height: 40.h),
              SizedBox(height: 6.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorApp.gery2,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorApp.gery1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}