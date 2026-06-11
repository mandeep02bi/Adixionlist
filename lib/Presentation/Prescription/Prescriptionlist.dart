import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Core/helper/token_storage_service.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
import 'package:doctor/Presentation/Prescription/AddperscriptionfirstDr.dart';
import 'package:doctor/Presentation/Prescription/cubit/prescription_cubit.dart';
import 'package:doctor/Presentation/Prescription/prescription_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Prescriptionlist extends StatefulWidget {
  final PatientModel? patient;
  const Prescriptionlist({super.key, this.patient});

  @override
  State<Prescriptionlist> createState() => _PrescriptionlistState();
}

class _PrescriptionlistState extends State<Prescriptionlist> {
  int expandedIndex = -1;
  bool _canAddPrescription = false; // only Doctor/Admin

  // Beautiful mockup list of prescriptions
  final List<Map<String, String>> _mockPrescriptions = [
    {
      "patientName": "Rishabh Singh",
      "patientCode": "PT-001",
      "diagnosis": "Viral Fever",
      "chiefComplaint":
          "High body temperature, throat irritation, dry cough for 3 days.",
      "prescriptionDate": "2026-05-26",
      "doctorName": "Dr. Subhash Sharma",
      "followUpDate": "2026-06-02",
    },
    {
      "patientName": "Amir Al-Otaibi",
      "patientCode": "PT-008",
      "diagnosis": "Acute Bronchitis",
      "chiefComplaint": "Shortness of breath, chest congestion, wheezing.",
      "prescriptionDate": "2026-05-22",
      "doctorName": "Dr. Subhash Sharma",
      "followUpDate": "2026-05-29",
    },
    {
      "patientName": "Fatima Zahra",
      "patientCode": "PT-012",
      "diagnosis": "Severe Migraine",
      "chiefComplaint":
          "Intense throbbing headache on left side, sensitivity to light, nausea.",
      "prescriptionDate": "2026-05-18",
      "doctorName": "Dr. Subhash Sharma",
      "followUpDate": "2026-06-18",
    },
    {
      "patientName": "John Doe",
      "patientCode": "PT-015",
      "diagnosis": "Hypertension",
      "chiefComplaint":
          "Elevated blood pressure (145/95), mild dizziness, fatigue.",
      "prescriptionDate": "2026-05-10",
      "doctorName": "Dr. Subhash Sharma",
      "followUpDate": "2026-05-24",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    try {
      final role = await getIt<TokenStorageService>().getUserRole();
      if (mounted) {
        setState(() {
          _canAddPrescription = role == 'Doctor' || role == 'Admin';
        });
      }
    } catch (e) {
      debugPrint("Error loading role in prescription list: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // If patient is specified, filter mock items to just that patient name
    final list =
        (widget.patient != null
              ? _mockPrescriptions
                    .map(
                      (item) => {
                        ...item,
                        "patientName":
                            "${widget.patient!.firstName} ${widget.patient!.lastName}",
                        "patientCode": widget.patient!.patientCode,
                      },
                    )
                    .toList()
              : List<Map<String, String>>.from(_mockPrescriptions))
          /// SORT DATE WISE (LATEST FIRST)
          ..sort((a, b) {
            final dateA =
                DateTime.tryParse(a["prescriptionDate"] ?? "") ??
                DateTime(2000);

            final dateB =
                DateTime.tryParse(b["prescriptionDate"] ?? "") ??
                DateTime(2000);

            return dateB.compareTo(dateA);
          });

    return Scaffold(
      body: Stack(
        children: [
          /// Background Gradient
          Positioned.fill(
            child: Image.asset(
              "assets/images/background/P.jpg",
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              /// Header Image
              Stack(
                children: [
                  Image.asset(
                    "assets/images/Header/header.png",
                    height: 110.h,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),

                  Positioned(
                    top: 40.h,
                    left: 15.w,
                    child: CircleAvatar(
                      radius: 22.r,
                      backgroundColor: Colors.white24,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset(
                          "assets/images/Icons/Patient/Frame.png",
                          height: 22.h,
                          width: 22.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 45.h,
                    left: 80.w,
                    child: Text(
                      widget.patient != null
                          ? "Patient Prescriptions"
                          : "Prescription History",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  if (widget.patient != null && _canAddPrescription)
                    Positioned(
                      top: 40.h,
                      right: 20.w,
                      child: CircleAvatar(
                        radius: 22.r,
                        backgroundColor: Colors.white24,
                        child: IconButton(
                          onPressed: () async {
                            final result = await Get.to(
                              () => Addperscriptionfirstdr(
                                patient: widget.patient!,
                              ),
                            );
                            if (result == true) {
                              // Re-trigger layout rebuild if we came back successfully
                              setState(() {});
                            }
                          },
                          icon: Image.asset(
                            "assets/images/Icons/Patient/Add.png",
                            height: 80.h,
                            width: 80.w,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 10.h),

              /// Prescription List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 20.h),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];

                    String itemInitials = "PT";
                    final name = item["patientName"] ?? "Unknown Patient";
                    if (name.isNotEmpty) {
                      final parts = name.split(' ');
                      if (parts.length >= 2) {
                        itemInitials =
                            "${parts[0][0].toUpperCase()}${parts[1][0].toUpperCase()}";
                      } else {
                        itemInitials = parts[0].substring(0, 2).toUpperCase();
                      }
                    }

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (widget.patient != null) {
                              Get.to(
                                () => BlocProvider(
                                  create: (_) => getIt<PrescriptionCubit>(),
                                  child: PrescriptionFormScreen(
                                    patient: widget.patient!,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 6.h,
                            ),
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Row(
                              children: [
                                /// Avatar
                                CircleAvatar(
                                  radius: 22.r,
                                  backgroundColor: Colors.blueGrey,
                                  child: Text(
                                    itemInitials,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
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
                                        name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      Text(
                                        "${item["patientCode"] ?? ''} • Diagnosis: ${item["diagnosis"] ?? 'Unspecified'}",
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

                        /// Dropdown Details
                        if (expandedIndex == index)
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 4.h,
                            ),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Prescription Details",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    "Chief Complaint: ${item["chiefComplaint"] ?? 'None'}",
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Date: ${item["prescriptionDate"] ?? 'Unspecified'}",
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Doctor: ${item["doctorName"] ?? 'Unknown Doctor'}",
                                  ),
                                  if (item["followUpDate"] != null) ...[
                                    SizedBox(height: 4.h),
                                    Text("Follow Up: ${item["followUpDate"]}"),
                                  ],
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
