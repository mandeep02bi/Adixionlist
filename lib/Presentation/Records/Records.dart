import 'package:doctor/Core/Theme/color_app.dart';
import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Core/helper/image_assets.dart';
import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
import 'package:doctor/Presentation/Patient/data/repo/patient_repo.dart';
import 'package:doctor/Presentation/Records/data/models/records_response.dart';
import 'package:doctor/Presentation/Records/logic/records_cubit.dart';
import 'package:doctor/Presentation/Records/logic/records_state.dart';
import 'package:doctor/Presentation/Records/prescription_record_pdf_screen.dart';
import 'package:doctor/Presentation/Records/widgets/container_body.dart';
import 'package:doctor/Presentation/Records/widgets/custom_header_recordes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:doctor/Presentation/Certificate/CertificatePdfScreen.dart';

import 'instruction_detail_screen.dart' show InstructionDetailsScreen;

class Records extends StatefulWidget {
  final PatientModel? patient;

  const Records({super.key, this.patient});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  int _activeTab = 0;
  List<PatientModel> patients = [];
  PatientModel? selectedPatient;
  bool _isLoadingPatients = false;

  @override
  void initState() {
    super.initState();
    if (widget.patient != null) {
      selectedPatient = widget.patient;
    } else {
      _loadPatients();
    }
  }

  void _loadPatients() async {
    setState(() {
      _isLoadingPatients = true;
    });
    final result = await getIt<PatientRepo>().getPatients();
    result.when(
      success: (data) {
        setState(() {
          patients = data.data ?? [];
          _isLoadingPatients = false;
        });
      },
      error: (_) {
        setState(() {
          _isLoadingPatients = false;
        });
      },
    );
  }

  String _formatDateString(String date) {
    try {
      final d = DateTime.parse(date);
      return DateFormat('dd-MMM yyyy').format(d);
    } catch (_) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecordsCubit>(
      create: (context) {
        final cubit = getIt<RecordsCubit>();
        if (selectedPatient != null) {
          cubit.getRecords(selectedPatient!.patientCode);
        }
        return cubit;
      },
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
                return Column(
                  children: [
                    CustomHeaderRecordes(
                      title: selectedPatient != null
                          ? "${selectedPatient!.firstName}’s Records"
                          : "Patient Records",
                      onTabChanged: (index) {
                        setState(() {
                          _activeTab = index;
                        });
                      },
                    ),
                    SizedBox(height: 10.h),
                    
                    // Patient Selection Dropdown (Only visible if opened from home screen without patient parameter)
                    if (widget.patient == null) ...[
                      _isLoadingPatients
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<PatientModel>(
                                  value: selectedPatient,
                                  hint: Text("Select Patient to view records", style: TextStyle(fontSize: 14.sp)),
                                  isExpanded: true,
                                  style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                                  items: patients.map((p) {
                                    return DropdownMenuItem<PatientModel>(
                                      value: p,
                                      child: Text("${p.fullName} (${p.patientCode})"),
                                    );
                                  }).toList(),
                                  onChanged: (p) {
                                    setState(() {
                                      selectedPatient = p;
                                    });
                                    if (p != null) {
                                      context.read<RecordsCubit>().getRecords(p.patientCode);
                                    }
                                  },
                                ),
                              ),
                            ),
                    ],

                    if (selectedPatient != null) ...[
                      ContainerBody(
                        name: selectedPatient!.fullName,
                        age: "${selectedPatient!.age ?? 0} Years",
                        email: selectedPatient!.phone ?? (selectedPatient!.firstName.toLowerCase() + "@patient.com"),
                        mobile: selectedPatient!.phone ?? "Unspecified",
                        date: selectedPatient!.createdAt != null
                            ? _formatDateString(selectedPatient!.createdAt!)
                            : "Today",
                      ),
                      Expanded(
                        child: BlocBuilder<RecordsCubit, RecordsState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              loading: () => const Center(child: CircularProgressIndicator()),
                              error: (errorMsg) => Center(
                                child: Text(
                                  "Error: $errorMsg",
                                  style: TextStyle(fontSize: 14.sp, color: Colors.red),
                                ),
                              ),
                              success: (data) {
                                final records = (data as RecordsResponse).data;
                                if (records == null) {
                                  return _buildEmptyState();
                                }
                                return _buildTabContent(records);
                              },
                              orElse: () => const Center(child: CircularProgressIndicator()),
                            );
                          },
                        ),
                      ),
                    ] else ...[
                      Expanded(
                        child: Center(
                          child: Text(
                            "Please select a patient to load records.",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        "No records found for this tab.",
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTabContent(RecordsData records) {
    if (_activeTab == 0) {
      final list = records.prescriptions ?? [];
      if (list.isEmpty) return _buildEmptyState();
      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return InkWell(
            onTap: () {
              Get.to(
                    () => PrescriptionRecordPdfScreen(
                  prescription: item,
                  patient: selectedPatient!,
                ),
              );
            },
            borderRadius: BorderRadius.circular(12.r),
            child: _buildRecordCard(
              title: item.diagnosis ?? "No Diagnosis",
              subtitle: item.chiefComplaint ?? "No Complaints",
              date: item.prescriptionDate ?? "",
              tag: item.doctorName != null ? "Dr. ${item.doctorName}" : "Prescription",
              tagColor: const Color(0xFF7B3FCF),
            ),
          );
        },
      );
    } else if (_activeTab == 1) {
      final list = records.certificates ?? [];
      if (list.isEmpty) return _buildEmptyState();
      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return  InkWell(
            onTap: () {
              Get.to(
                    () => CertificatePdfScreen(
                  patientName: selectedPatient?.fullName ?? "",
                  title: item.title,
                  description: item.description??"",
                  doctorName: item.doctorName ?? "",
                ),
              );
            },
            child: _buildRecordCard(
              title: item.title,
              subtitle: "Medical Certificate",
              date: item.certificateDate,
              tag: item.doctorName != null
                  ? "Dr. ${item.doctorName}"
                  : "Certificate",
              tagColor: const Color(0xFF4CAF50),
            ),
          );
        },
      );
    } else if (_activeTab == 2) {
      final list = records.instructions ?? [];
      if (list.isEmpty) return _buildEmptyState();
      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return InkWell(
            onTap: () {
              Get.to(
                    () => InstructionDetailsScreen(
                  id: item.id,
                      title: item.title,
                      description: item.description??"",
                      doctorName: item.doctorName??" ",
                      date: item.instructionDate,
                ),
              );
            },
            child: _buildRecordCard(
              title: item.title,
              subtitle: "Care Instructions",
              date: item.instructionDate,
              tag: item.doctorName != null
                  ? "Dr. ${item.doctorName}"
                  : "Instruction",
              tagColor: const Color(0xFFFF9800),
            ),
          );
        },
      );
    } else {
      final list = records.invoices ?? [];
      if (list.isEmpty) return _buildEmptyState();
      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          final isPaid = item.status.toLowerCase() == "paid";
          return _buildRecordCard(
            title: item.invoiceTitle,
            subtitle: "Amount: ${item.totalAmount}",
            date: "",
            tag: item.status,
            tagColor: isPaid ? Colors.green : Colors.red,
          );
        },
      );
    }
  }

  Widget _buildRecordCard({
    required String title,
    required String subtitle,
    required String date,
    required String tag,
    required Color tagColor,
  }) {
    String formattedDate = date;
    if (date.isNotEmpty) {
      try {
        final d = DateTime.parse(date);
        formattedDate = DateFormat('dd MMM yyyy').format(d);
      } catch (_) {}
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black54,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (formattedDate.isNotEmpty) ...[
                  SizedBox(height: 6.h),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: tagColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: tagColor.withOpacity(0.3), width: 1.w),
            ),
            child: Text(
              tag,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: tagColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
