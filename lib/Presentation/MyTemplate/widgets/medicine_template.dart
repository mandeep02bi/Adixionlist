import 'package:doctor/core/Theme/color_app.dart';
import 'package:doctor/Core/helper/image_assets.dart';
import 'package:doctor/Presentation/MyTemplate/widgets/patine_widgets_template.dart';
import 'package:doctor/Presentation/Prescription/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicineTemplate extends StatelessWidget {
  const MedicineTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: Column(
        children: [
          CustomTextFormField(
            label: '',
            hint: 'My medicine',
            fieldFillColor: ColorApp.scaffoldColor,
            icon: ImageAssets.blood,
            heightIcon: 18.h,
            widthIcon: 18.w,
            hintStyle: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10.h),
          const PatineWidgetsTemplate(),
          SizedBox(height: 10.h),
          const PatineWidgetsTemplate(),
          SizedBox(height: 10.h),
          const PatineWidgetsTemplate(),
          SizedBox(height: 10.h),
          const PatineWidgetsTemplate(),
          SizedBox(height: 10.h),
          const PatineWidgetsTemplate(),
        ],
      ),
    );
  }
}

