import 'package:doctor/widgets/Add_patient/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPatientScreenAddressAndLocation extends StatelessWidget {
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController zipCodeController;

  const AddPatientScreenAddressAndLocation({
    super.key,
    required this.streetController,
    required this.cityController,
    required this.stateController,
    required this.zipCodeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        CustomFormField(
          label: 'Street address',
          hint: 'House No., Street, Area...',
          keyboardType: TextInputType.multiline,
          controller: streetController,
        ),
        SizedBox(height: 20.h),
        CustomFormField(
          label: 'City / District',
          hint: 'Jaipur',
          icon: 'assets/images/Icons/Patient/Add/Skyscraper.png',
          widthIcon: 18.w,
          heightIcon: 18.h,
          controller: cityController,
        ),
        SizedBox(height: 20.h),
        CustomFormField(
          label: 'State',
          hint: 'Bihar',
          icon: 'assets/images/Icons/Patient/Add/Skyscraper.png',
          widthIcon: 18.w,
          heightIcon: 18.h,
          controller: stateController,
        ),
        SizedBox(height: 20.h),
        CustomFormField(
          label: 'Zip Code',
          hint: '800001',
          keyboardType: TextInputType.number,
          controller: zipCodeController,
        ),
      ],
    );
  }
}

