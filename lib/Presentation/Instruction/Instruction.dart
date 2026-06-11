import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
import 'package:doctor/Presentation/Instruction/data/models/instruction_response.dart';
import 'package:doctor/Presentation/Instruction/logic/instruction_cubit.dart';
import 'package:doctor/Presentation/Instruction/logic/instruction_state.dart';
import 'package:doctor/Presentation/Instruction/AddInstruction.dart';
import 'package:doctor/widgets/Common/Appheader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Instruction extends StatefulWidget {
  final PatientModel patient;
  const Instruction({super.key, required this.patient});

  @override
  State<Instruction> createState() => _InstructionState();
}

class _InstructionState extends State<Instruction> {
  @override
  Widget build(BuildContext context) {
    String initials = "PT";
    if (widget.patient.firstName.isNotEmpty && widget.patient.lastName.isNotEmpty) {
      initials = "${widget.patient.firstName[0].toUpperCase()}${widget.patient.lastName[0].toUpperCase()}";
    }

    return BlocProvider<InstructionCubit>(
      create: (context) => getIt<InstructionCubit>()..getInstructions(widget.patient.patientCode),
      child: Scaffold(
        backgroundColor: const Color(0xFFE9F1F6),
        body: Column(
          children: [
            /// 🔷 HEADER
            Builder(
              builder: (context) => AppHeader(
                title: "Care Instruction",
                onBack: () => Navigator.pop(context),
                onAdd: () async {
                  final result = await Get.to(() => AddInstruction(patient: widget.patient));
                  if (result == true && context.mounted) {
                    context.read<InstructionCubit>().getInstructions(widget.patient.patientCode);
                  }
                },
                backgroundImage: "assets/images/background/P.jpg",
              ),
            ),

            /// 👤 USER TILE
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF3F6),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22.r,
                      backgroundColor: Colors.blueGrey,
                      child: Text(
                        initials,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      widget.patient.fullName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    )
                  ],
                ),
              ),
            ),

            /// 📄 TITLE
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Instructions List",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10.h),

            /// 📋 LIST
            Expanded(
              child: BlocBuilder<InstructionCubit, InstructionState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error) => Center(
                      child: Text(
                        "Error loading data: $error",
                        style: TextStyle(fontSize: 14.sp, color: Colors.red),
                      ),
                    ),
                    success: (data) {
                      final list = (data as InstructionListResponse).data ?? [];

                      if (list.isEmpty) {
                        return Center(
                          child: Text(
                            "No Care Instructions Found",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final item = list[index];

                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 6.h),
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF3F6),
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: ExpansionTile(
                              trailing: PopupMenuButton<String>(
                                itemBuilder: (_) => const [
                                  PopupMenuItem(
                                    value: "edit",
                                    child: Text("Edit"),
                                  ),
                                  PopupMenuItem(
                                    value: "delete",
                                    child: Text("Delete"),
                                  ),
                                ],
                                onSelected: (value) {
                                  // edit or delete
                                },
                              ),
                              title: Text(
                                item.title??"",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                ),
                              ),
                              subtitle: Text(
                                _formatDate(item.instructionDate??""),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              childrenPadding: EdgeInsets.all(8.r),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    item.description??"",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    orElse: () => const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String _formatDate(String date) {
    try {
      final d = DateTime.parse(date);
      return "${d.day} / ${d.month} / ${d.year}";
    } catch (_) {
      return date;
    }
  }
}