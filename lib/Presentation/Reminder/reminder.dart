import 'package:doctor/core/Theme/color_app.dart';
import 'package:doctor/Core/helper/image_assets.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
import 'package:doctor/Presentation/Reminder/reminder_notes.dart';
import 'package:doctor/Presentation/Reminder/reminder_pay.dart';
import 'package:doctor/Presentation/Reminder/widgets/action_button.dart';
import 'package:doctor/Presentation/Reminder/widgets/custom_header_reminder.dart';
import 'package:doctor/Presentation/Reminder/widgets/user_drop_down_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Reminder extends StatefulWidget {
  final PatientModel patient;
  final bool isExpanded;

  const Reminder({super.key, required this.patient, this.isExpanded = false});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  Widget _buildExpandedSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: const Color(0xFFEEEEEE), width: 1.w),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ActionButton(
            image: ImageAssets.wallet,
            label: 'Payment',
            onPressed: () => Get.to(() => ReminderPay(patient: widget.patient)),
          ),
          ActionButton(
            image: ImageAssets.notes,
            label: 'Reminder',
            onPressed: () => Get.to(() => ReminderNotes(patient: widget.patient)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.scaffoldColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.backgroundImagePath2),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const CustomHeaderReminder(title: 'Set Reminder'),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: UserDropdownCard(
                  name: widget.patient.fullName,
                  imagePath: ImageAssets.at,
                  expandedSection: _buildExpandedSection(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
