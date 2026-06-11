import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateCard extends StatelessWidget {
  final String day;
  final String date;
  final bool active;

  const DateCard({
    super.key,
    required this.day,
    required this.date,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white70,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Text(day,
              style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
          SizedBox(height: 6.h),
          Text(date,
              style: TextStyle(
                  fontSize: 18.sp, fontWeight: FontWeight.bold)),
          Text("Mar",
              style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
        ],
      ),
    );
  }
}