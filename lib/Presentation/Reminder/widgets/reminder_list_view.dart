import 'package:doctor/Core/helper/image_assets.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
import 'package:doctor/Presentation/Reminder/reminder_notes.dart';
import 'package:doctor/Presentation/Reminder/reminder_pay.dart';
import 'package:doctor/Presentation/Reminder/widgets/action_button.dart';
import 'package:doctor/Presentation/Reminder/widgets/user_drop_down_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

class ReminderListView extends StatelessWidget {
  final List<Map<String, String>> users;
  final PatientModel patient;

  const ReminderListView({
    super.key,
    required this.users,
    required this.patient,
  });

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
            image: ImageAssets.reminder,
            label: 'Set Reminder',
            onPressed: () {},
          ),
          ActionButton(
            image: ImageAssets.wallet,
            label: 'Payment',
            onPressed: () => Get.to(ReminderPay(patient: patient)),
          ),
          ActionButton(
            image: ImageAssets.notes,
            label: 'Reminder',
            onPressed: () => Get.to(ReminderNotes(patient: patient)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      itemCount: users.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final user = users[index];
        return UserDropdownCard(
          name: user['name'] ?? '',
          imagePath: user['image'] ?? ImageAssets.at,
          expandedSection: _buildExpandedSection(),
        );
      },
    );
  }
}
