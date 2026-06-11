import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGenderSelection extends StatefulWidget {
  final Function(String) onGenderChanged;
  final String? initialValue;

  const CustomGenderSelection({
    super.key,
    required this.onGenderChanged,
    this.initialValue,
  });

  @override
  State<CustomGenderSelection> createState() => _CustomGenderSelectionState();
}

class _CustomGenderSelectionState extends State<CustomGenderSelection> {
  late String selectedGender;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.initialValue ?? "Male";
  }

  @override
  Widget build(BuildContext context) {
    final List<String> genders = ["Male", "Female", "Other"];

    return Row(
      children: genders.map((gender) {
        bool isSelected = gender == selectedGender;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedGender = gender;
            });
            widget.onGenderChanged(gender);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.only(right: 10.w),
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFE6F7F2) : Colors.white,
              borderRadius: BorderRadius.circular(25.r),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF0F6E56).withOpacity(0.3)
                    : Colors.grey.shade200,
                width: isSelected ? 1.5.w : 1.w,
              ),
            ),
            child: Text(
              gender,
              style: TextStyle(
                color: isSelected ? const Color(0xFF0F6E56) : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}