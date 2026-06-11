import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHeaderWidgets extends StatelessWidget {
  final String? title;
  const CustomHeaderWidgets({super.key, this.title});

  List<String> getSteps(String title) {
    if (title.toLowerCase().contains("prescription")) {
      return ["Case History", "Medical", "Lab Test"];
    } else {
      return ["Personal", "Medical", "Address"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return SizedBox(
          height: orientation == Orientation.portrait ? 110.h : 80.h,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/background/header.png',
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            'assets/images/Icons/Patient/Frame.png',
                            width: orientation == Orientation.portrait
                                ? 35.w
                                : 25.w,
                            height: orientation == Orientation.portrait
                                ? 35.61.h
                                : 25.61.h,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title ?? 'Add New Patient',
                              style: TextStyle(
                                fontSize: orientation == Orientation.portrait
                                    ? 20.sp
                                    : 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            if (orientation == Orientation.portrait) ...[
                              SizedBox(height: 4.h),
                              Text(
                                'Fill in patient details',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xFFD0DCF4),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
