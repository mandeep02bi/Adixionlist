import 'package:doctor/Core/helper/image_assets.dart';
import 'package:doctor/Core/Controller.dart/drawercontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomHeaderHome extends StatelessWidget {
  const CustomHeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        return Container(
          height: isPortrait ? 90.h : 70.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.homePageHeader),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi Doctor",
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: "Rubik",
                        fontSize: isPortrait ? 12.sp : 10.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Subhash Sharma",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isPortrait ? 16.sp : 14.sp,
                        fontFamily: "Rubik",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  try {
                    final controller = Get.find<DrawerControllerX>();
                    controller.toggleDrawer();
                  } catch (e) {
                    debugPrint("DrawerControllerX not found: $e");
                  }
                },
                child: CircleAvatar(
                  radius: isPortrait ? 22.r : 18.r,
                  backgroundImage: AssetImage(ImageAssets.homeIcon),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
