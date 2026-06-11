import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
import 'package:doctor/Presentation/Certificate/data/models/certificate_request_body.dart';
import 'package:doctor/Presentation/Certificate/logic/certificate_cubit.dart';
import 'package:doctor/Presentation/Certificate/logic/certificate_state.dart';
import 'package:doctor/widgets/Common/Appheader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Addcertificate extends StatefulWidget {
  final PatientModel patient;
  const Addcertificate({super.key, required this.patient});

  @override
  State<Addcertificate> createState() => _AddcertificateState();
}

class _AddcertificateState extends State<Addcertificate> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  void saveCertificate(BuildContext context) {
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

    final body = CertificateRequestBody(
      patientCode: widget.patient.patientCode,
      title: title,
      description: desc,
      certificateDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );

    context.read<CertificateCubit>().createCertificate(body);
  }

  @override
  Widget build(BuildContext context) {
    String initials = "PT";
    if (widget.patient.firstName.isNotEmpty && widget.patient.lastName.isNotEmpty) {
      initials = "${widget.patient.firstName[0].toUpperCase()}${widget.patient.lastName[0].toUpperCase()}";
    }

    return BlocProvider<CertificateCubit>(
      create: (context) => getIt<CertificateCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0xFFE9F1F6),
        body: Builder(
          builder: (context) {
            return BlocListener<CertificateCubit, CertificateState>(
              listener: (context, state) {
                state.maybeWhen(
                  success: (data) {
                    Get.snackbar(
                      "Success",
                      "Certificate created successfully!",
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
                    children: [
                      /// HEADER
                      AppHeader(
                        title: "Certificate",
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
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 20.h),

                              /// TITLE FIELD
                              TextField(
                                controller: titleController,
                                style: TextStyle(fontSize: 14.sp),
                                decoration: InputDecoration(
                                  hintText: "Certificate Title",
                                  hintStyle: TextStyle(fontSize: 14.sp),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              ),

                              SizedBox(height: 15.h),

                              /// DESCRIPTION FIELD
                              TextField(
                                controller: descController,
                                maxLines: 3,
                                style: TextStyle(fontSize: 14.sp),
                                decoration: InputDecoration(
                                  hintText: "Description",
                                  hintStyle: TextStyle(fontSize: 14.sp),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              ),

                              SizedBox(height: 25.h),

                              /// BUTTON
                              _bookButton(context)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  BlocBuilder<CertificateCubit, CertificateState>(
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

  Widget _bookButton(BuildContext context) {
    return GestureDetector(
      onTap: () => saveCertificate(context),
      child: Container(
        height: 55.h,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF7B3FCF), Color(0xFF9C27B0)],
          ),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Center(
          child: Text(
            "Prescribe",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}