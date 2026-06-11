import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/core/Theme/color_app.dart';
import 'package:doctor/Core/helper/image_assets.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
import 'package:doctor/Presentation/Reminder/data/models/reminder_request_body.dart';
import 'package:doctor/Presentation/Reminder/logic/reminder_cubit.dart';
import 'package:doctor/Presentation/Reminder/logic/reminder_state.dart';
import 'package:doctor/Presentation/Reminder/widgets/custom_header_reminder.dart';
import 'package:doctor/widgets/Add_patient/custom_section_title.dart';
import 'package:doctor/widgets/Add_patient/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReminderNotes extends StatefulWidget {
  final PatientModel patient;

  const ReminderNotes({super.key, required this.patient});

  @override
  State<ReminderNotes> createState() => _ReminderNotesState();
}

class _ReminderNotesState extends State<ReminderNotes> {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 7));

  @override
  void initState() {
    titleCtrl.text = "Follow-up Appointment";
    descCtrl.text = "Remember to take your medications daily.";
    super.initState();
  }

  void saveReminder(BuildContext context) {
    final title = titleCtrl.text.trim();
    final desc = descCtrl.text.trim();

    if (title.isEmpty || desc.isEmpty) {
      Get.snackbar(
        "Required Fields",
        "Please enter title and description.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    final body = ReminderRequestBody(
      patientCode: widget.patient.patientCode,
      reminderType: "Reminder",
      title: title,
      description: desc,
      startDate: DateFormat('yyyy-MM-dd').format(startDate),
      endDate: DateFormat('yyyy-MM-dd').format(endDate),
    );

    context.read<ReminderCubit>().createReminder(body);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReminderCubit>(
      create: (context) => getIt<ReminderCubit>(),
      child: Scaffold(
        backgroundColor: ColorApp.scaffoldColor,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageAssets.backgroundImagePath2),
                fit: BoxFit.cover,
              ),
            ),
            child: Builder(
              builder: (context) {
                return BlocListener<ReminderCubit, ReminderState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      success: (data) {
                        Get.snackbar(
                          "Success",
                          "Reminder set successfully!",
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                        Navigator.pop(context, true);
                      },
                      error: (errorMsg) {
                        Get.snackbar(
                          "Error Creating",
                          errorMsg,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      },
                      orElse: () {},
                    );
                  },
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomHeaderReminder(title: 'Set Reminder'),
                          SizedBox(height: 10.h),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 70.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 8.r,
                                            offset: Offset(0, 2.h),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              ImageAssets.at,
                                              width: 40.w,
                                              height: 38.h,
                                            ),
                                            SizedBox(width: 12.w),
                                            Expanded(
                                              child: Text(
                                                widget.patient.fullName,
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: const Color(0xFF1A1A2E),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15.h),
                                    CustomSectionTitle(
                                      icon: ImageAssets.drugs,
                                      title: 'Reminder Details',
                                      widthIcon: 18.w,
                                      heightIcon: 18.h,
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomFormField(
                                      label: 'TITLE',
                                      hint: 'Enter Reminder Title',
                                      controller: titleCtrl,
                                      hintStyle: TextStyle(
                                        fontSize: 11.sp,
                                        color: ColorApp.labelTextColor,
                                      ),
                                      fieldFillColor: Colors.white,
                                      icon: ImageAssets.blood,
                                      heightIcon: 18.h,
                                      widthIcon: 18.w,
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomFormField(
                                      label: 'DESCRIPTION',
                                      hint: 'e.g. Remember to bring medical history...',
                                      controller: descCtrl,
                                      hintStyle: TextStyle(
                                        fontSize: 11.sp,
                                        color: ColorApp.labelTextColor,
                                      ),
                                      fieldFillColor: Colors.white,
                                      keyboardType: TextInputType.multiline,
                                    ),
                                    SizedBox(height: 15.h),
                                    Text(
                                      'Select Schedule',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: const Color(0xFF2C2C2C),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 15.h),
                                    
                                    // Custom schedule picker using standard fields
                                    _dateField("Start Date", startDate, (d) {
                                      setState(() {
                                        startDate = d;
                                      });
                                    }),
                                    SizedBox(height: 10.h),
                                    _dateField("End Date", endDate, (d) {
                                      setState(() {
                                        endDate = d;
                                      });
                                    }),
                                    
                                    SizedBox(height: 30.h),
                                    
                                    // Save Button
                                    ElevatedButton(
                                      onPressed: () => saveReminder(context),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF7B3FCF),
                                        minimumSize: Size(double.infinity, 50.h),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.r),
                                        ),
                                      ),
                                      child: Text(
                                        "Save Reminder",
                                        style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Loader overlay
                      BlocBuilder<ReminderCubit, ReminderState>(
                        builder: (context, state) {
                          final isLoading = state.maybeWhen(
                            loading: () => true,
                            orElse: () => false,
                          );
                          if (isLoading) {
                            return Container(
                              color: Colors.black.withOpacity(0.3),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _dateField(String label, DateTime date, ValueChanged<DateTime> onPicked) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 11.sp, color: ColorApp.labelTextColor, fontWeight: FontWeight.bold)),
        SizedBox(height: 6.h),
        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (picked != null) {
              onPicked(picked);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat('yyyy-MM-dd').format(date), style: TextStyle(fontSize: 14.sp)),
                const Icon(Icons.calendar_month, color: Colors.green),
              ],
            ),
          ),
        )
      ],
    );
  }
}
