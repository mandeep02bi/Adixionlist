import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class InstructionDetailsScreen extends StatelessWidget {
  final String title;
  final String description;
  final String doctorName;
  final String date;
  final int id;

  const InstructionDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.doctorName,
    required this.date,
    required this.id
  });

  String formatDate(String dateStr) {
    try {
      // Parses the ISO string from the API and formats it
      DateTime dateTime = DateTime.parse(dateStr);
      return DateFormat('dd MMM, yyyy').format(dateTime); // Result: Jun 12, 2026
    } catch (e) {
      // If parsing fails, return the original string
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Instruction Details",style: TextStyle(fontWeight: FontWeight.w500),),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10.h),

                Text(
                  "Doctor: $doctorName",
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),

                SizedBox(height: 5.h),

                Text(
                  "Date: ${formatDate(date)}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                ),

                Divider(height: 30.h),

                Text(
                  "Instructions",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 10.h),

                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}