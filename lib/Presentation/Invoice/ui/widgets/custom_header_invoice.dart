import 'package:doctor/Core/helper/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHeaderInvoice extends StatelessWidget {
  final String title;
  final Widget? bottomCard;

  const CustomHeaderInvoice({super.key, required this.title, this.bottomCard});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: orientation == Orientation.portrait ? 100.h : 65.h,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(ImageAssets.headerPrescription, fit: BoxFit.fill),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(
                            height: orientation == Orientation.portrait
                                ? 30.h
                                : 15.h),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Row(
                            children: [
                              Image.asset(
                                ImageAssets.backBottom,
                                width: orientation == Orientation.portrait
                                    ? 35.w
                                    : 25.w,
                                height: orientation == Orientation.portrait
                                    ? 35.h
                                    : 25.h,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: orientation == Orientation.portrait
                                      ? 18.sp
                                      : 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (bottomCard != null)
              Positioned(
                bottom: -50.h,
                left: 16.w,
                right: 16.w,
                child: bottomCard!,
              ),
          ],
        );
      },
    );
  }
}


