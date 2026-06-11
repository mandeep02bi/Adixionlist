import 'package:doctor/core/Theme/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordCard extends StatelessWidget {
  final String items;
  final String itemname;
  final String subitemname;
  const RecordCard({
    super.key,
    required this.items,
    required this.itemname,
    required this.subitemname,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: ColorApp.textColor, width: 1.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(items, width: 60.w, height: 60.h),
              Text(
                itemname,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorApp.hintColor,
                ),
              ),
              Text(
                subitemname,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorApp.labelColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

