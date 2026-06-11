import 'package:animate_do/animate_do.dart';
import 'package:doctor/Core/helper/image_assets.dart';
import 'package:doctor/core/Theme/color_app.dart';
import 'package:doctor/Presentation/HomeScreen/widgets/crousel_slider.dart';
import 'package:doctor/Presentation/HomeScreen/widgets/grid_menu.dart';
import 'package:doctor/Presentation/HomeScreen/widgets/record_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 15.h),

          const CarouselSliderWidget(),

          Padding(
            padding: EdgeInsets.all(10.w),
            child: FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: ColorApp.textColor, width: 1.w),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      Image.asset(
                        ImageAssets.iconUpgrade,
                        height: 35.h,
                        width: 35.w,
                      ),
                      SizedBox(width: 15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upgrade to Premium',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorApp.hintColor,
                            ),
                          ),
                          Text(
                            'Easy access to better care',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorApp.labelColor,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),

                      Container(
                        height: 31.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: ColorApp.buttomColor,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Center(
                          child: Text(
                            'Upgrade',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorApp.scaffoldColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: const GridMenu(),
          ),

          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: const RecordSection(),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

