import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicineCard extends StatelessWidget {
  final String medicineName;
  final String dosage;
  final String frequency;
  final String days;
  final VoidCallback onDelete;

  const MedicineCard({
    super.key,
    required this.medicineName,
    required this.dosage,
    required this.frequency,
    required this.days,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),

      padding: EdgeInsets.all(14.w),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16.r),

        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.05)),
        ],
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,

            backgroundColor: const Color(0xFFFFF4DD),

            child: Icon(Icons.medication, size: 18.sp),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  medicineName,

                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  "$dosage • $frequency • $days days",

                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: onDelete,

            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    );
  }
}
