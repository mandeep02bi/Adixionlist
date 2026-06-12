import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Presentation/Appointment/Appointment.dart';
import 'package:doctor/Presentation/Attachedfile/Attachedfile.dart';
import 'package:doctor/Presentation/Attachment/Attachment.dart';
import 'package:doctor/Presentation/Certificate/Certificate.dart';
import 'package:doctor/Presentation/Instruction/Instruction.dart';
import 'package:doctor/Presentation/Invoice/ui/Invoice.dart';
import 'package:doctor/Presentation/Patient/add_patient_screen.dart';
import 'package:doctor/Presentation/Patient/data/models/patients_list_response.dart';
import 'package:doctor/Presentation/Patient/logic/patient_cubit.dart';
import 'package:doctor/Presentation/Patient/logic/patient_state.dart';
import 'package:doctor/Presentation/Prescription/Prescriptionlist.dart';
import 'package:doctor/Presentation/Records/Records.dart';
import 'package:doctor/Presentation/Reminder/reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  int expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatientListCubit>(
      create: (context) => getIt<PatientListCubit>()..getPatients(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF24937D),
          onPressed: () async {
            final result = await Get.to(() => const AddPatientScreen());

            if (result == true) {
              if (context.mounted) {
                context.read<PatientListCubit>().getPatients();
              }
            }
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: Stack(
          children: [
            /// Background Gradient
            Positioned.fill(
              child: Image.asset(
                "assets/images/background/P.jpg",
                fit: BoxFit.cover,
              ),
            ),

            Builder(
              builder: (context) {
                return Column(
                  children: [
                    /// Header Image
                    OrientationBuilder(
                      builder: (context, orientation) {
                        return Stack(
                          children: [
                            Image.asset(
                              "assets/images/Header/header.png",
                              height: orientation == Orientation.portrait
                                  ? 110.h
                                  : 70.h,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: orientation == Orientation.portrait
                                  ? 40.h
                                  : 25.h,
                              left: 15.w,
                              child: CircleAvatar(
                                radius: orientation == Orientation.portrait
                                    ? 22.r
                                    : 18.r,
                                backgroundColor: Colors.white24,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Image.asset(
                                    "assets/images/Icons/Patient/Frame.png",
                                    height: orientation == Orientation.portrait
                                        ? 22.h
                                        : 18.h,
                                    width: orientation == Orientation.portrait
                                        ? 22.w
                                        : 18.w,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: orientation == Orientation.portrait
                                  ? 45.h
                                  : 30.h,
                              left: 80.w,
                              child: Text(
                                "List of Patient",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: orientation == Orientation.portrait
                                      ? 20.sp
                                      : 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    SizedBox(height: 10.h),

                    /// Patient List
                    Expanded(
                      child: BlocBuilder<PatientListCubit, PatientListState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (errorMsg) => Center(
                              child: Text(
                                errorMsg,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            success: (responseData) {
                              final list =
                                  (responseData as PatientsListResponse).data ??
                                  [];

                              if (list.isEmpty) {
                                return Center(
                                  child: Text(
                                    "No Patients Found",
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                );
                              }

                              return ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  final item = list[index];

                                  // Extract Initials
                                  String initials = "PT";
                                  if (item.firstName.isNotEmpty &&
                                      item.lastName.isNotEmpty) {
                                    initials =
                                        "${item.firstName[0].toUpperCase()}${item.lastName[0].toUpperCase()}";
                                  }

                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            expandedIndex =
                                                expandedIndex == index
                                                ? -1
                                                : index;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 16.w,
                                            vertical: 6.h,
                                          ),
                                          padding: EdgeInsets.all(12.w),
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius: BorderRadius.circular(
                                              15.r,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              /// Avatar
                                              CircleAvatar(
                                                radius: 22.r,
                                                backgroundColor:
                                                    Colors.blueGrey,
                                                child: Text(
                                                  initials,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),

                                              SizedBox(width: 12.w),

                                              /// Name
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.fullName,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${item.patientCode}.Age ${item.age ?? 0} Years (${item.gender ?? 'Unspecified'})",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Icon(
                                                expandedIndex == index
                                                    ? Icons.keyboard_arrow_up
                                                    : Icons.keyboard_arrow_down,
                                                size: 24.r,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      /// Dropdown Grid
                                      if (expandedIndex == index)
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 12.w,
                                          ),
                                          padding: EdgeInsets.all(5.w),
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius: BorderRadius.circular(
                                              15.r,
                                            ),
                                          ),
                                          child: OrientationBuilder(
                                            builder: (context, orientation) {
                                              return GridView.count(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                crossAxisCount:
                                                    orientation ==
                                                        Orientation.portrait
                                                    ? 3
                                                    : 5,
                                                childAspectRatio:
                                                    orientation ==
                                                        Orientation.portrait
                                                    ? 1.3
                                                    : 1.5,
                                                children: [
                                                  gridItem(
                                                    "assets/images/Icons/Patient/p.png",
                                                    "Prescribe",
                                                    Prescriptionlist(
                                                      patient: item,
                                                    ),
                                                  ),
                                                  gridItem(
                                                    "assets/images/Icons/Patient/Attach.png",
                                                    "Attachment",
                                                    const Attachment(),
                                                  ),
                                                  gridItem(
                                                    "assets/images/Icons/Patient/Instructions.png",
                                                    "Instruction",
                                                    Instruction(patient: item),
                                                  ),
                                                  gridItem(
                                                    "assets/images/Icons/Patient/Notes.png",
                                                    "Records",
                                                    Records(patient: item),
                                                  ),
                                                  gridItem(
                                                    "assets/images/Icons/Patient/Calendar.png",
                                                    "Appointment",
                                                    Appointment(patient: item),
                                                  ),
                                                  gridItem(
                                                    "assets/images/Icons/Patient/Reminder.png",
                                                    "Set Reminder",
                                                    Reminder(patient: item),
                                                  ),
                                                  gridItem(
                                                    "assets/images/Icons/Patient/p.png",
                                                    "Attach file",
                                                    const Attachedfile(),
                                                  ),
                                                  gridItem(
                                                    "assets/images/Icons/Patient/Bill.png",
                                                    "Invoice",
                                                    const Invoice(),
                                                  ),
                                                  gridItem(
                                                    "assets/images/Icons/Patient/Certificate.png",
                                                    "Certificate",
                                                    Certificate(patient: item),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              );
                            },
                            orElse: () => const Center(
                              child: Text("Loading patients list..."),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget gridItem(String icon, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Get.to(() => page);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, height: 40.h),
          SizedBox(height: 5.h),
          Text(title, style: TextStyle(fontSize: 12.sp)),
        ],
      ),
    );
  }
}
