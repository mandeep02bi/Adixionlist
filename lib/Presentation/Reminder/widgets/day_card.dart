import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DayCard extends StatelessWidget {
  final DateTime day;
  final bool isSelected;
  final VoidCallback onTap;

  const DayCard({
    super.key,
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 78.w,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F5F0) : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF2EAF8A) : const Color(0xFFE0E0E0),
            width: isSelected ? 1.5.w : 0.5.w,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              DateFormat('EEE').format(day),
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: isSelected ? const Color(0xFF2EAF8A) : const Color(0xFF888888),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              '${day.day}',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: isSelected ? const Color(0xFF2EAF8A) : const Color(0xFF1A1A2E),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              DateFormat('MMM').format(day),
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: isSelected ? const Color(0xFF2EAF8A) : const Color(0xFF888888),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

