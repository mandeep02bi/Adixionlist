import 'package:doctor/Core/Theme/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoleSelector extends StatelessWidget {
  final String selected;
  final void Function(String) onChanged;

  const RoleSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ['Doctor', 'Staff'].map((role) {
        final isSelected = selected == role;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(role),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(right: role == 'Doctor' ? 10.w : 0),
              height: 50.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? ColorApp.buttomColor
                    : Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isSelected
                      ? ColorApp.buttomColor
                      : const Color(0xFFE0E0E0),
                ),
              ),
              child: Center(
                child: Text(
                  role,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : ColorApp.labelTextColor,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
