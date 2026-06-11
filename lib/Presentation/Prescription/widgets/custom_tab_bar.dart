import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChanged;

  const CustomTabBar({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = ["Case History", "Medical", "Lab Test"];

    return Container(
      color: const Color(0xFFF5FCFF),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: List.generate(tabs.length, (index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              onChanged(index);
            },

            child: SizedBox(
              width: 95.w,

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    tabs[index],

                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,

                      color: isSelected
                          ? const Color(0xFF1D1D1D)
                          : const Color(0xFFC7C7C7),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),

                    height: 2.5.h,
                    width: 78.w,

                    decoration: BoxDecoration(
                      color: isSelected ? Colors.black : Colors.transparent,

                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
