import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Presentation/Instruction/data/models/instruction_response.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
import 'package:doctor/Presentation/Instruction/data/models/instruction_request_body.dart';
import 'package:doctor/Presentation/Instruction/logic/instruction_cubit.dart';
import 'package:doctor/Presentation/Instruction/logic/instruction_state.dart';
import 'package:doctor/widgets/Common/Appheader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddInstruction extends StatefulWidget {
  final InstructionModel? instruction;
  final bool isEdit;
  final PatientModel patient;
  const AddInstruction({super.key, required this.patient, this.instruction, this.isEdit = false});

  @override
  State<AddInstruction> createState() => _AddInstructionState();
}

class _AddInstructionState extends State<AddInstruction> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.isEdit &&
        widget.instruction != null) {

      titleController.text =
          widget.instruction!.title ?? '';

      descController.text =
          widget.instruction!.description ?? '';
    }
  }

  void saveInstruction(BuildContext context) {
    final title = titleController.text.trim();
    final desc = descController.text.trim();

    if (title.isEmpty || desc.isEmpty) {
      Get.snackbar(
        "Required Fields",
        "Please enter title and description.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    final body = InstructionRequestBody(
      patientCode: widget.patient.patientCode,
      title: title,
      description: desc,
      instructionDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );

    if (widget.isEdit) {
      context.read<InstructionCubit>().updateInstruction(
        widget.instruction!.id!,
        body,
      );
    } else {
      context.read<InstructionCubit>().createInstruction(body);
    }
  }

  @override
  Widget build(BuildContext context) {
    String initials = "PT";
    if (widget.patient.firstName.isNotEmpty && widget.patient.lastName.isNotEmpty) {
      initials = "${widget.patient.firstName[0].toUpperCase()}${widget.patient.lastName[0].toUpperCase()}";
    }

    return BlocProvider<InstructionCubit>(
      create: (context) => getIt<InstructionCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0xFFE9F1F6),
        body: Builder(
          builder: (context) {
            return BlocListener<InstructionCubit, InstructionState>(
              listener: (context, state) {
                print("STATE = $state");
                state.maybeWhen(
                  success: (data) {
                    print("SUCCESS CALLED");
                    Get.snackbar(
                      "Success",
                      widget.isEdit
                          ? "Instruction updated successfully!"
                          : "Care instruction created successfully!",
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                    Navigator.pop(context, true);
                  },
                  error: (error) {
                    if (error.isNotEmpty) {
                      Get.snackbar(
                        "Error Creating",
                        error,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  orElse: () {},
                );
              },
              child: Stack(
                children: [
                  Column(
                    children: [
                      /// HEADER
                      AppHeader(
                        title:  widget.isEdit
                            ? "Update Instruction"
                            : "Care Instruction",
                        onBack: () => Navigator.pop(context),
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(16.r),
                          child: Column(
                            children: [
                              /// USER TILE
                              Container(
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

                              SizedBox(height: 25.h),

                              /// FORM TITLE
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Create Instruction",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),

                              SizedBox(height: 15.h),

                              /// INPUT TITLE
                              TextField(
                                controller: titleController,
                                decoration: InputDecoration(
                                  labelText: "Title",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),

                              SizedBox(height: 15.h),

                              /// INPUT CONTENT
                              TextField(
                                controller: descController,
                                maxLines: 6,
                                decoration: InputDecoration(
                                  labelText: "Description",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),

                              SizedBox(height: 25.h),

                              /// BTN SAVE
                              SizedBox(
                                width: double.infinity,
                                height: 48.h,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF0F6E56),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                  onPressed: () => saveInstruction(context),
                                  child: Text(
                                    widget.isEdit
                                        ? "Update"
                                        : "Save",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// LOADING INDICATOR
                  BlocBuilder<InstructionCubit, InstructionState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loading: () => Container(
                          color: Colors.black26,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        orElse: () => const SizedBox.shrink(),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
