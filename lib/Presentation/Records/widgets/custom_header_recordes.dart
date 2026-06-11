import 'package:doctor/core/Theme/color_app.dart';
import 'package:doctor/Core/helper/image_assets.dart';
import 'package:doctor/Presentation/Prescription/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHeaderRecordes extends StatefulWidget {
  final String title;
  final Widget? bottomCard;
  final ValueChanged<int>? onTabChanged;

  const CustomHeaderRecordes({
    super.key,
    required this.title,
    this.bottomCard,
    this.onTabChanged,
  });

  @override
  State<CustomHeaderRecordes> createState() => _CustomHeaderRecordesState();
}

class _CustomHeaderRecordesState extends State<CustomHeaderRecordes> {
  int _selectedIndex = 0;

  bool _isActive(int tabIndex) => _selectedIndex == tabIndex;

  void _onTabTap(int index) {
    setState(() => _selectedIndex = index);
    widget.onTabChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      ImageAssets.headeRecordes,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: 35.r,
                                height: 35.r,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                  size: 18.r,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            const Expanded(
                              child: CustomTextFormField(
                                label: '',
                                hint: 'Type here to search',
                                hintStyle: TextStyle(
                                  fontSize: 11,
                                  color: ColorApp.scaffoldColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                heightIcon: 38,
                                widthIcon: 283,
                                fieldFillColor: Colors.transparent,
                                borderColor: ColorApp.scaffoldColor,
                                focusedBorderColor: ColorApp.scaffoldColor,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              height: 44.h,
                              width: 52.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text(
                                  'Go',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorApp.hintColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildTab('Prescriptions', 0),
                              SizedBox(width: 10.w),
                              _buildTab('Certificates', 1),
                              SizedBox(width: 10.w),
                              _buildTab('Instructions', 2),
                              SizedBox(width: 10.w),
                              _buildTab('Invoices', 3),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (widget.bottomCard != null)
              Positioned(
                bottom: -50.h,
                left: 16.w,
                right: 16.w,
                child: widget.bottomCard!,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildTab(String label, int index) {
    final active = _isActive(index);
    return GestureDetector(
      onTap: () => _onTabTap(index),
      child: Container(
        height: 44.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          border: active ? null : Border.all(color: Colors.white, width: 1.5.w),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: active ? ColorApp.hintColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

