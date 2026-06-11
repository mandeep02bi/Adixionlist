import 'package:doctor/Core/widgets/header_cricles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHaderPreview extends StatelessWidget {
  final String title;
  final Widget? bottomCard;

  const CustomHaderPreview({
    super.key,
    this.title = 'Write Prescription',
    this.bottomCard,
  });

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: orientation == Orientation.portrait ? 120.h : 80.h,

              width: double.infinity,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(42.r),
                  bottomRight: Radius.circular(42.r),
                ),

                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.0, 0.43, 0.93],
                  colors: [
                    Color(0xFF24937D),
                    Color(0xFF367793),
                    Color(0xFF4E51B1),
                  ],
                ),
              ),

              child: Stack(
                children: [
                  /// RIGHT BLUR CIRCLE
                  Positioned(
                    right: -40.w,
                    top: -10.h,

                    child: Container(
                      width: 170.w,
                      height: 170.h,

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  /// CONTENT
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),

                    child: Column(
                      children: [
                        SizedBox(
                          height: orientation == Orientation.portrait
                              ? 40.h
                              : 18.h,
                        ),

                        Row(
                          children: [
                            /// BACK BUTTON
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },

                              child: Container(
                                width: orientation == Orientation.portrait
                                    ? 44.w
                                    : 34.w,

                                height: orientation == Orientation.portrait
                                    ? 44.h
                                    : 34.h,

                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.18),

                                  borderRadius: BorderRadius.circular(14.r),
                                ),

                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                  size: 18.sp,
                                ),
                              ),
                            ),

                            SizedBox(width: 14.w),

                            /// TITLE
                            Expanded(
                              child: Text(
                                title,

                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,

                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: orientation == Orientation.portrait
                                      ? 20.sp
                                      : 15.sp,
                                ),
                              ),
                            ),

                            /// DATE CONTAINER
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),

                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.22),

                                borderRadius: BorderRadius.circular(16.r),
                              ),

                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                    size: 12.sp,
                                  ),

                                  SizedBox(width: 6.w),

                                  Text(
                                    '12 Mar 2026',

                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// FLOATING TAB SECTION
            if (bottomCard != null)
              Positioned(bottom: -36.h, left: 0, right: 0, child: bottomCard!),
          ],
        );
      },
    );
  }
}
