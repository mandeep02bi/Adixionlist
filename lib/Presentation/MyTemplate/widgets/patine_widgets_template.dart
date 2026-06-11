import 'package:doctor/core/Theme/color_app.dart';
import 'package:doctor/Core/helper/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatineWidgetsTemplate extends StatelessWidget {
  final String name;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onView;

  const PatineWidgetsTemplate({
    super.key,
    this.name = 'Rishabh Singh',
    this.onDelete,
    this.onEdit,
    this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: ColorApp.labelColor, width: 1.w),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              ImageAssets.at,
              width: 40.51.w,
              height: 38.51.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
          Row(
            children: [
              // 🗑 Delete
              GestureDetector(
                onTap: onDelete,
                child: Image.asset(ImageAssets.delete, height: 22.h, width: 22.w),
              ),
              SizedBox(width: 8.w),
              // ✏️ Edit
              GestureDetector(
                onTap: onEdit,
                child: Image.asset(ImageAssets.pencile, height: 16.h, width: 16.w),
              ),
              SizedBox(width: 8.w),
              // 👁 View
              GestureDetector(
                onTap: onView,
                child: Image.asset(ImageAssets.eye, height: 27.h, width: 25.w),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

