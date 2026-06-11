import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
import 'package:doctor/Presentation/Certificate/data/models/certificate_response.dart';
import 'package:doctor/Presentation/Certificate/logic/certificate_cubit.dart';
import 'package:doctor/Presentation/Certificate/logic/certificate_state.dart';
import 'package:doctor/Presentation/Certificate/AddCertificate.dart';
import 'package:doctor/widgets/Certificate/Certificcatecard.dart';
import 'package:doctor/widgets/Common/Appheader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Certificate extends StatefulWidget {
  final PatientModel patient;
  const Certificate({super.key, required this.patient});

  @override
  State<Certificate> createState() => _CertificateState();
}

class _CertificateState extends State<Certificate> {
  @override
  Widget build(BuildContext context) {
    String initials = "PT";
    if (widget.patient.firstName.isNotEmpty && widget.patient.lastName.isNotEmpty) {
      initials = "${widget.patient.firstName[0].toUpperCase()}${widget.patient.lastName[0].toUpperCase()}";
    }

    return BlocProvider<CertificateCubit>(
      create: (context) => getIt<CertificateCubit>()..getCertificates(widget.patient.patientCode),
      child: Scaffold(
        backgroundColor: const Color(0xFFE9F1F6),
        body: Column(
          children: [
            /// 🔷 HEADER
            Builder(
              builder: (context) => AppHeader(
                title: "Certificate",
                onBack: () => Navigator.pop(context),
                onAdd: () async {
                  final result = await Get.to(() => Addcertificate(patient: widget.patient));
                  if (result == true && context.mounted) {
                    context.read<CertificateCubit>().getCertificates(widget.patient.patientCode);
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
                  "Certificate",
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
              child: BlocBuilder<CertificateCubit, CertificateState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (errorMsg) => Center(
                      child: Text(
                        "Error loading data: $errorMsg",
                        style: TextStyle(fontSize: 14.sp, color: Colors.red),
                      ),
                    ),
                    success: (data) {
                      final list = (data as CertificateListResponse).data ?? [];

                      if (list.isEmpty) {
                        return Center(
                          child: Text(
                            "No Certificates Found",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final item = list[index];

                          return CertificateCard(
                            title: item.title,
                            date: _formatDate(item.certificateDate),
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
      return "${d.day} ${_month(d.month)} ${d.year}";
    } catch (_) {
      return date;
    }
  }

  String _month(int m) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    if (m < 1 || m > 12) return "";
    return months[m - 1];
  }
}