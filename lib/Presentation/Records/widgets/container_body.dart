import 'package:doctor/core/Theme/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerBody extends StatelessWidget {
  final String name;
  final String age;
  final String email;
  final String mobile;
  final String date;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ContainerBody({
    super.key,
    required this.name,
    required this.age,
    required this.email,
    required this.mobile,
    required this.date,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11.r),
        border: Border.all(color: ColorApp.boderContainer, width: 2.w),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 14.h, bottom: 10.h),
            child: Text(
              date,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
            child: Column(
              children: [
                buildRow('Name:', name),
                SizedBox(height: 8.h),
                buildRow('Age :', age),
                SizedBox(height: 8.h),
                buildRow('Email:', email),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(child: buildRow('Mobile:', mobile)),
                    GestureDetector(
                      onTap: onEdit,
                      child: Container(
                        width: 38.r,
                        height: 38.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade100,
                        ),
                        child: Icon(
                          Icons.edit_outlined,
                          size: 18.r,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: onDelete,
                      child: Container(
                        width: 38.r,
                        height: 38.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade100,
                          border: Border.all(color: ColorApp.labelColor),
                        ),
                        child: Icon(
                          Icons.delete_outline,
                          size: 18.r,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 55.w,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

