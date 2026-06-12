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
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show read;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'logic/reminder_cubit.dart';
import 'logic/reminder_state.dart';

class Reminder extends StatefulWidget {
  final PatientModel patient;
  final bool isExpanded;

  const Reminder({super.key, required this.patient, this.isExpanded = false});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  @override
  void initState() {
    super.initState();

    context.read<ReminderCubit>().getReminders(
      patientCode: widget.patient.patientCode,
    );
  }

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return '';

    final parsedDate = DateTime.parse(date);

    return DateFormat('d/M/yyyy').format(parsedDate);
  }

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
            onPressed: () async {

              final result = await Get.to(
                    () => ReminderPay(
                  patient: widget.patient,
                ),
              );

              if (result == true) {
                context.read<ReminderCubit>().getReminders(
                  patientCode: widget.patient.patientCode,
                );
              }
            },  ),
          ActionButton(
            image: ImageAssets.notes,
            label: 'Reminder',
            onPressed: () async {
              final result = await Get.to(
                () => ReminderNotes(patient: widget.patient),
              );

              if (result == true) {
                context.read<ReminderCubit>().getReminders(
                  patientCode: widget.patient.patientCode,
                );
              }
            },
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: UserDropdownCard(
                          name: widget.patient.fullName,
                          imagePath: ImageAssets.at,
                          expandedSection: _buildExpandedSection(),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      BlocBuilder<ReminderCubit, ReminderState>(
                        builder: (context, state) {
                          return state.when(
                            initial: () => const SizedBox(),

                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),

                            success: (response) {
                              final reminders = response.data ?? [];

                              if (reminders.isEmpty) {
                                return const Center(
                                  child: Text('No Reminders Found'),
                                );
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: reminders.length,
                                itemBuilder: (context, index) {
                                  final reminder = reminders[index];

                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                    ),
                                    child: Card(
                                      color: Colors.white,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 8.h,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              reminder.title ?? '',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                              ),
                                            ),

                                            SizedBox(height: 5.h),

                                            Text(reminder.description ?? ''),

                                            SizedBox(height: 8.h),

                                            Text(
                                              "Type : ${reminder.reminderType}",
                                            ),

                                            Text(
                                              "Start : ${formatDate(reminder.startDate)}",
                                            ),

                                            Text(
                                              "End : ${formatDate(reminder.endDate)}",
                                            ),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () async {

                                                    if (reminder.reminderType == "Payment Reminder") {

                                                      final result = await Get.to(
                                                            () => ReminderPay(
                                                          patient: widget.patient,
                                                          isEdit: true,
                                                          reminderData: reminder,
                                                        ),
                                                      );

                                                      if (result == true) {
                                                        context.read<ReminderCubit>().getReminders(
                                                          patientCode: widget.patient.patientCode,
                                                        );
                                                      }

                                                    } else {

                                                      final result = await Get.to(
                                                            () => ReminderNotes(
                                                          patient: widget.patient,
                                                          isEdit: true,
                                                          reminderData: reminder,
                                                        ),
                                                      );

                                                      if (result == true) {
                                                        context.read<ReminderCubit>().getReminders(
                                                          patientCode: widget.patient.patientCode,
                                                        );
                                                      }
                                                    }
                                                  },
                                                  child: Text(
                                                    "Update",
                                                    style: TextStyle(
                                                      color: Color(0xff4561A5),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (_) => AlertDialog(
                                                        title: const Text(
                                                          "Delete",
                                                        ),
                                                        content: const Text(
                                                          "Are you sure you want to delete this instruction?",
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                  context,
                                                                ),
                                                            child: const Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                color: Color(
                                                                  0xff4561A5,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              context
                                                                  .read<
                                                                    ReminderCubit
                                                                  >()
                                                                  .deleteReminder(
                                                                    id: reminder
                                                                        .id!,
                                                                    patientCode: widget
                                                                        .patient
                                                                        .patientCode,
                                                                  );
                                                              Get.snackbar(
                                                                "Success",
                                                                "Reminder deleted successfully !!",
                                                                backgroundColor:
                                                                    Colors.red,
                                                                colorText:
                                                                    Colors
                                                                        .white,
                                                              );
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            },
                                                            child: Text(
                                                              "Delete",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },

                            error: (message) {
                              return Center(child: Text(message));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
