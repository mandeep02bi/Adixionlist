import 'package:animate_do/animate_do.dart';
import 'package:doctor/Core/helper/image_assets.dart';
import 'package:doctor/Presentation/Records/records.dart';
import 'package:doctor/core/Theme/color_app.dart';
import 'package:doctor/Presentation/Patient/Patientlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class GridMenu extends StatelessWidget {
  const GridMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      "Patient List",
      "Appointments",
      "My Templates",
      "Send Notifications",
      "View Records",
    ];
    final itemsimage = [
      ImageAssets.patientListIcon,
      ImageAssets.appointmentIcon,
      ImageAssets.templateIcon,
      ImageAssets.notificationIocn,
      ImageAssets.reportIocn,
    ];

    return OrientationBuilder(
      builder: (context, orientation) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: orientation == Orientation.portrait ? 3 : 5,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w,
            childAspectRatio: orientation == Orientation.portrait ? 0.80 : 1.1,
          ),
          itemBuilder: (context, index) {
            return FadeInUp(
              delay: Duration(milliseconds: 100 * index),
              child: GestureDetector(
                onTap: () {
                  if (items[index] == "Patient List") {
                    Get.to(const PatientListScreen());
                  }
                  if (items[index] == "View Records") {
                    Get.to(() => const Records());
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(color: ColorApp.textColor, width: 1.w),
                  ),
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        itemsimage[index],
                        width: orientation == Orientation.portrait
                            ? 45.w
                            : 35.w,
                        height: orientation == Orientation.portrait
                            ? 42.h
                            : 32.h,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        items[index],
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Rubik",
                          fontSize: orientation == Orientation.portrait
                              ? 12.sp
                              : 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
