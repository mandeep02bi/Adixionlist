import 'dart:io';

import 'package:doctor/Core/services/prescription_pdf_service.dart';
import 'package:doctor/Core/widgets/custom_button.dart';
import 'package:doctor/Data/model/lab_test_request_body.dart';
import 'package:doctor/Data/model/medicine_request_body.dart';
import 'package:doctor/Data/model/prescription_request_body.dart';
import 'package:doctor/Data/model/prescription_response.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
import 'package:doctor/Presentation/Prescription/AddprescriptionthiDr.dart';
import 'package:doctor/Presentation/Prescription/cubit/prescription_state.dart';
import 'package:doctor/Presentation/Prescription/widgets/custom_hader_preview.dart';
import 'package:doctor/core/Theme/color_app.dart';
import 'package:doctor/Core/helper/image_assets.dart';
import 'package:doctor/Presentation/Prescription/AddperscriprionsecDr.dart';
import 'package:doctor/widgets/Add_patient/custom_text_field.dart';
import 'package:doctor/Data/Data_source/Medicine_datasource.dart';
import 'package:doctor/Presentation/Prescription/cubit/prescription_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:open_filex/open_filex.dart';

class Addperscriptionfirstdr extends StatefulWidget {
  final PatientModel patient;
  const Addperscriptionfirstdr({super.key, required this.patient});

  @override
  State<Addperscriptionfirstdr> createState() => _AddperscriptionfirstdrState();
}

class _AddperscriptionfirstdrState extends State<Addperscriptionfirstdr>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Case History controllers
  final _diagnosisByStaffCtrl = TextEditingController();
  final _diagnosisCtrl = TextEditingController();
  final _findingCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _allergyCtrl = TextEditingController();
  final _chiefComplaintCtrl = TextEditingController();
  final _treatmentCtrl = TextEditingController();
  final _spo2Ctrl = TextEditingController();
  final _respirationCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _followUpCtrl = TextEditingController();

  DateTime? _followUpDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _followUpCtrl.text = DateFormat(
      'yyyy-MM-dd',
    ).format(DateTime.now().add(const Duration(days: 7)));
    _followUpDate = DateTime.now().add(const Duration(days: 7));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _diagnosisByStaffCtrl.dispose();
    _diagnosisCtrl.dispose();
    _findingCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _allergyCtrl.dispose();
    _chiefComplaintCtrl.dispose();
    _treatmentCtrl.dispose();
    _spo2Ctrl.dispose();
    _respirationCtrl.dispose();
    _notesCtrl.dispose();
    _followUpCtrl.dispose();
    super.dispose();
  }

  // ── Build request body from form fields ──────────────────────────────────

  PrescriptionRequestBody _buildPrescriptionBody() {
    return PrescriptionRequestBody(
      patientCode: widget.patient.patientCode, // adjust field name as needed
      height: _heightCtrl.text.trim().isEmpty ? null : _heightCtrl.text.trim(),
      weight: _weightCtrl.text.trim().isEmpty ? null : _weightCtrl.text.trim(),
      spo2: _spo2Ctrl.text.trim().isEmpty ? null : _spo2Ctrl.text.trim(),
      respirationRate: _respirationCtrl.text.trim().isEmpty
          ? null
          : _respirationCtrl.text.trim(),
      allergy: _allergyCtrl.text.trim().isEmpty
          ? null
          : _allergyCtrl.text.trim(),
      chiefComplaint: _chiefComplaintCtrl.text.trim().isEmpty
          ? null
          : _chiefComplaintCtrl.text.trim(),
      findings: _findingCtrl.text.trim().isEmpty
          ? null
          : _findingCtrl.text.trim(),
      diagnosis: _diagnosisCtrl.text.trim().isEmpty
          ? null
          : _diagnosisCtrl.text.trim(),
      treatmentAdvice: _treatmentCtrl.text.trim().isEmpty
          ? null
          : _treatmentCtrl.text.trim(),
      notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
      followUpDate: _followUpCtrl.text.trim().isEmpty
          ? null
          : _followUpCtrl.text.trim(),
      prescriptionDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );
  }

  // ── Read medicines from local SQLite draft DB ─────────────────────────────

  Future<List<MedicineRequestBody>> _getMedicines() async {
    final localMeds = await MedicineDatabase.instance.getAllMedicines();
    return localMeds
        .map(
          (m) => MedicineRequestBody(
            name: m.name,
            totalQuantity: m.totalQuantity,
            frequency: m.frequency,
            routeForm: m.routeForm,
            noOfDays: m.noOfDays,
            instructions: m.instructions,
            additionalComments: m.additionalComments,
          ),
        )
        .toList();
  }

  Future<List<LabTestRequestBody>> _getLabTests() async {
    final localTests = await MedicineDatabase.instance.getAllLabTests();
    return localTests
        .map(
          (t) => LabTestRequestBody(
            testName: t.testName,
            additionalComments: t.additionalComments,
          ),
        )
        .toList();
  }

  // ── Prescribe button handler ──────────────────────────────────────────────

  Future<void> _onPresscribe() async {
    final medicines = await _getMedicines();
    final labTests = await _getLabTests();

    final body = _buildPrescriptionBody();

    if (!mounted) return;

    context.read<PrescriptionCubit>().createFullPrescription(
      prescriptionBody: body,
      medicines: medicines,
      labTests: labTests,
    );
  }

  // ── Handle PDF after success ──────────────────────────────────────────────
  Future<void> _openPdf(PrescriptionDetail detail) async {
    try {
      final body = _buildPrescriptionBody();

      final medicines = (detail.medicines ?? []).map((e) {
        return MedicineRequestBody(
          name: e.name,
          frequency: e.frequency,
          noOfDays: e.noOfDays,
          routeForm: e.routeForm,
          instructions: e.instructions,
          totalQuantity: e.totalQuantity,
          additionalComments: e.additionalComments,
        );
      }).toList();

      final labTests = (detail.labTests ?? []).map((e) {
        return LabTestRequestBody(
          testName: e.testName,
          additionalComments: e.additionalComments,
        );
      }).toList();

      final file = await PrescriptionPdfService.generate(
        patient: widget.patient,
        prescription: body,
        medicines: medicines,
        labTests: labTests,
      );

      await OpenFilex.open(file.path);

      await MedicineDatabase.instance.clearAllMedicines();
      await MedicineDatabase.instance.clearAllLabTests();

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (e) {
      Get.snackbar(
        'PDF Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PrescriptionCubit, PrescriptionState>(
      listener: (context, state) {
        if (state is PrescriptionSuccess) {
          _openPdf(state.detail);
        } else if (state is PrescriptionError) {
          Get.snackbar(
            'Error',
            state.message,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
      child: Scaffold(
        backgroundColor: ColorApp.scaffoldColor,
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background/05_Home screen.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomHaderPreview(title: 'Write a Prescription'),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: ColorApp.hintColor,
                        unselectedLabelColor: const Color(0xFF808080),
                        labelStyle: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: ColorApp.hintColor,
                        dividerColor: Colors.transparent,
                        tabs: const [
                          Tab(text: 'CASE HISTORY'),
                          Tab(text: 'MEDICINE'),
                          Tab(text: 'LAB TEST'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildCaseHistoryTab(context),
                          const Addperscriprionsecdr(),
                          Addperscriptionthirddr(onPrescribe: _onPresscribe),
                        ],
                      ),
                    ),
                  ],
                ),
                // ── Loading overlay ──────────────────────────────────────
                BlocBuilder<PrescriptionCubit, PrescriptionState>(
                  builder: (context, state) {
                    if (state is PrescriptionLoading ||
                        state is PrescriptionProgress) {
                      return Container(
                        color: Colors.black38,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CircularProgressIndicator(
                                color: Color(0xFF4FA3A5),
                              ),
                              SizedBox(height: 16.h),
                              if (state is PrescriptionProgress)
                                Text(
                                  state.message,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCaseHistoryTab(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            // Patient chip
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18.r,
                    backgroundColor: const Color(0xFF4FA3A5),
                    child: Text(
                      widget.patient.firstName.isNotEmpty
                          ? widget.patient.firstName[0].toUpperCase()
                          : 'P',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      widget.patient.fullName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            CustomFormField(
              label: 'DIAGNOSIS By Staff',
              hint: 'Viral Fever & Throat Infection',
              controller: _diagnosisByStaffCtrl,
              fieldFillColor: const Color(0xFFF9FCFF),
              icon: ImageAssets.stethoscope,
              widthIcon: 18.w,
              heightIcon: 18.h,
            ),
            SizedBox(height: 12.h),
            CustomFormField(
              label: 'DIAGNOSIS',
              hint: 'Cough',
              controller: _diagnosisCtrl,
              fieldFillColor: const Color(0xFFF9FCFF),
              icon: ImageAssets.stethoscope,
              widthIcon: 18.w,
              heightIcon: 18.h,
            ),
            SizedBox(height: 12.h),
            CustomFormField(
              label: 'Finding',
              hint: 'Findings...',
              controller: _findingCtrl,
              fieldFillColor: const Color(0xFFF9FCFF),
              icon: ImageAssets.stethoscope,
              widthIcon: 18.w,
              heightIcon: 18.h,
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: CustomFormField(
                    label: 'Height (cm)',
                    hint: '170',
                    controller: _heightCtrl,
                    fieldFillColor: const Color(0xFFFFFFFF),
                    icon: ImageAssets.heightPrescription,
                    keyboardType: TextInputType.number,
                    widthIcon: 16.w,
                    heightIcon: 16.h,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomFormField(
                    fieldFillColor: const Color(0xFFFFFFFF),
                    icon: ImageAssets.weight,
                    label: 'Weight (kg)',
                    hint: '70',
                    controller: _weightCtrl,
                    widthIcon: 16.w,
                    heightIcon: 16.h,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: CustomFormField(
                    label: 'Spo2',
                    hint: '98%',
                    controller: _spo2Ctrl,
                    fieldFillColor: const Color(0xFFFFFFFF),
                    icon: ImageAssets.heightPrescription,
                    widthIcon: 16.w,
                    heightIcon: 16.h,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomFormField(
                    fieldFillColor: const Color(0xFFFFFFFF),
                    icon: ImageAssets.weight,
                    label: 'Respiration',
                    hint: '18',
                    controller: _respirationCtrl,
                    widthIcon: 16.w,
                    heightIcon: 16.h,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            CustomFormField(
              label: 'Allergy',
              hint: 'Penicillin...',
              controller: _allergyCtrl,
              fieldFillColor: const Color(0xFFF9FCFF),
              icon: ImageAssets.stethoscope,
              widthIcon: 18.w,
              heightIcon: 18.h,
            ),
            SizedBox(height: 12.h),
            CustomFormField(
              label: 'Chief Complaint',
              hint: 'Add chief complaint...',
              controller: _chiefComplaintCtrl,
              hintStyle: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF787878),
              ),
              fieldFillColor: const Color(0xFFF9FCFF),
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 12.h),
            CustomFormField(
              label: 'Treatment or Advice',
              hint: 'Add instructions, follow-up advice, restrictions...',
              controller: _treatmentCtrl,
              hintStyle: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF787878),
              ),
              fieldFillColor: const Color(0xFFF9FCFF),
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 12.h),
            CustomFormField(
              label: "DOCTOR'S NOTES",
              hint: 'Add instructions, follow-up advice, restrictions...',
              controller: _notesCtrl,
              hintStyle: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF787878),
              ),
              fieldFillColor: const Color(0xFFF9FCFF),
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 12.h),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _followUpDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  setState(() {
                    _followUpDate = picked;
                    _followUpCtrl.text = DateFormat(
                      'yyyy-MM-dd',
                    ).format(picked);
                  });
                }
              },
              child: CustomFormField(
                label: 'FOLLOW-UP DATE',
                hint: 'mm/dd/yyyy',
                controller: _followUpCtrl,
                fieldFillColor: const Color(0xFFF9FCFF),
                icon: ImageAssets.calender,
                suffixIconPath: ImageAssets.data,
                widthIcon: 12.w,
                heightIcon: 12.h,
              ),
            ),
            SizedBox(height: 25.h),
            // Prescribe button on Case History tab also triggers the full flow
            CustomButton(
              onPressed: _onPresscribe,
              height: 45.83.h,
              width: 130.w,
              icon: ImageAssets.drft,
              text: 'Prescribe',
              textStyle: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: ColorApp.textColor,
              ),
              buttonColor: Colors.transparent,
              border: Border.all(color: ColorApp.textColor, width: 1.w),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}

// import 'package:doctor/Core/widgets/custom_button.dart';
// import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
// import 'package:doctor/Presentation/Prescription/AddprescriptionthiDr.dart';
// import 'package:doctor/Presentation/Prescription/widgets/custom_hader_preview.dart';
// import 'package:doctor/core/Theme/color_app.dart';
// import 'package:doctor/Core/helper/image_assets.dart';
// import 'package:doctor/Presentation/Prescription/AddperscriprionsecDr.dart';
// import 'package:doctor/widgets/Add_patient/custom_text_field.dart';
// import 'package:doctor/Data/Data_source/Medicine_datasource.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class Addperscriptionfirstdr extends StatefulWidget {
//   final PatientModel patient;
//   const Addperscriptionfirstdr({super.key, required this.patient});

//   @override
//   State<Addperscriptionfirstdr> createState() => _AddperscriptionfirstdrState();
// }

// class _AddperscriptionfirstdrState extends State<Addperscriptionfirstdr>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   // Case History controllers
//   final _diagnosisByStaffCtrl = TextEditingController();
//   final _diagnosisCtrl = TextEditingController();
//   final _findingCtrl = TextEditingController();
//   final _heightCtrl = TextEditingController();
//   final _weightCtrl = TextEditingController();
//   final _allergyCtrl = TextEditingController();
//   final _chiefComplaintCtrl = TextEditingController();
//   final _treatmentCtrl = TextEditingController();
//   final _spo2Ctrl = TextEditingController();
//   final _respirationCtrl = TextEditingController();
//   final _notesCtrl = TextEditingController();
//   final _followUpCtrl = TextEditingController();

//   DateTime? _followUpDate;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _followUpCtrl.text = DateFormat(
//       'yyyy-MM-dd',
//     ).format(DateTime.now().add(const Duration(days: 7)));
//     _followUpDate = DateTime.now().add(const Duration(days: 7));
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _diagnosisByStaffCtrl.dispose();
//     _diagnosisCtrl.dispose();
//     _findingCtrl.dispose();
//     _heightCtrl.dispose();
//     _weightCtrl.dispose();
//     _allergyCtrl.dispose();
//     _chiefComplaintCtrl.dispose();
//     _treatmentCtrl.dispose();
//     _spo2Ctrl.dispose();
//     _respirationCtrl.dispose();
//     _notesCtrl.dispose();
//     _followUpCtrl.dispose();
//     super.dispose();
//   }

//   void _submitPrescription(BuildContext context) async {
//     Get.snackbar(
//       "Success",
//       "Prescription created successfully!",
//       backgroundColor: Colors.green,
//       colorText: Colors.white,
//       snackPosition: SnackPosition.BOTTOM,
//     );
//     // Clear dynamic draft databases
//     await MedicineDatabase.instance.clearAllMedicines();
//     await MedicineDatabase.instance.clearAllLabTests();
//     Navigator.pop(context, true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorApp.scaffoldColor,
//       body: SafeArea(
//         child: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(
//                 "assets/images/background/05_Home screen.jpg",
//               ),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Stack(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const CustomHaderPreview(
//                     title: "Write a Prescription",
//                   ),
//                   OrientationBuilder(
//                     builder: (context, orientation) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 18.w),
//                         child: TabBar(
//                           controller: _tabController,
//                           labelColor: ColorApp.hintColor,
//                           unselectedLabelColor: const Color(0xFF808080),
//                           labelStyle: TextStyle(
//                             fontSize: 10.sp,
//                             fontWeight: FontWeight.w600,
//                           ),
//                           indicatorSize: TabBarIndicatorSize.tab,
//                           indicatorColor: ColorApp.hintColor,
//                           dividerColor: Colors.transparent,
//                           tabs: const [
//                             Tab(text: "CASE HISTORY"),
//                             Tab(text: "MEDICINE"),
//                             Tab(text: "LAB TEST"),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                   Expanded(
//                     child: TabBarView(
//                       controller: _tabController,
//                       children: [
//                         _buildCaseHistoryTab(context),
//                         const Addperscriprionsecdr(),
//                         Addperscriptionthirddr(
//                           onPrescribe: () =>
//                               _submitPrescription(context),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCaseHistoryTab(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 18.w),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 8.h),
//             // Patient chip
//             Container(
//               padding: EdgeInsets.all(10.r),
//               decoration: BoxDecoration(
//                 color: Colors.white.withValues(alpha: 0.85),
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 18.r,
//                     backgroundColor: const Color(0xFF4FA3A5),
//                     child: Text(
//                       widget.patient.firstName.isNotEmpty
//                           ? widget.patient.firstName[0].toUpperCase()
//                           : "P",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10.w),
//                   Expanded(
//                     child: Text(
//                       widget.patient.fullName,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14.sp,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 12.h),
//             CustomFormField(
//               label: 'DIAGNOSIS By Staff',
//               hint: 'Viral Fever & Throat Infection',
//               controller: _diagnosisByStaffCtrl,
//               fieldFillColor: const Color(0xFFF9FCFF),
//               icon: ImageAssets.stethoscope,
//               widthIcon: 18.w,
//               heightIcon: 18.h,
//             ),
//             SizedBox(height: 12.h),
//             CustomFormField(
//               label: 'DIAGNOSIS',
//               hint: 'Cough',
//               controller: _diagnosisCtrl,
//               fieldFillColor: const Color(0xFFF9FCFF),
//               icon: ImageAssets.stethoscope,
//               widthIcon: 18.w,
//               heightIcon: 18.h,
//             ),
//             SizedBox(height: 12.h),
//             CustomFormField(
//               label: 'Finding',
//               hint: 'Findings...',
//               controller: _findingCtrl,
//               fieldFillColor: const Color(0xFFF9FCFF),
//               icon: ImageAssets.stethoscope,
//               widthIcon: 18.w,
//               heightIcon: 18.h,
//             ),
//             SizedBox(height: 12.h),
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomFormField(
//                     label: 'Height (cm)',
//                     hint: '170',
//                     controller: _heightCtrl,
//                     fieldFillColor: const Color(0xFFFFFFFF),
//                     icon: ImageAssets.heightPrescription,
//                     keyboardType: TextInputType.number,
//                     widthIcon: 16.w,
//                     heightIcon: 16.h,
//                   ),
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(
//                   child: CustomFormField(
//                     fieldFillColor: const Color(0xFFFFFFFF),
//                     icon: ImageAssets.weight,
//                     label: 'Weight (kg)',
//                     hint: '70',
//                     controller: _weightCtrl,
//                     widthIcon: 16.w,
//                     heightIcon: 16.h,
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 12.h),
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomFormField(
//                     label: 'Spo2',
//                     hint: '98%',
//                     controller: _spo2Ctrl,
//                     fieldFillColor: const Color(0xFFFFFFFF),
//                     icon: ImageAssets.heightPrescription,
//                     widthIcon: 16.w,
//                     heightIcon: 16.h,
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(
//                   child: CustomFormField(
//                     fieldFillColor: const Color(0xFFFFFFFF),
//                     icon: ImageAssets.weight,
//                     label: 'Respiration',
//                     hint: '18',
//                     controller: _respirationCtrl,
//                     widthIcon: 16.w,
//                     heightIcon: 16.h,
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 12.h),
//             CustomFormField(
//               label: 'Allergy',
//               hint: 'Penicillin...',
//               controller: _allergyCtrl,
//               fieldFillColor: const Color(0xFFF9FCFF),
//               icon: ImageAssets.stethoscope,
//               widthIcon: 18.w,
//               heightIcon: 18.h,
//             ),
//             SizedBox(height: 12.h),
//             CustomFormField(
//               label: 'Chief Complaint',
//               hint: 'Add chief complaint...',
//               controller: _chiefComplaintCtrl,
//               hintStyle: TextStyle(
//                 fontSize: 12.sp,
//                 color: const Color(0xFF787878),
//               ),
//               fieldFillColor: const Color(0xFFF9FCFF),
//               keyboardType: TextInputType.multiline,
//             ),
//             SizedBox(height: 12.h),
//             CustomFormField(
//               label: 'Treatment or Advice',
//               hint: 'Add instructions, follow-up advice, restrictions...',
//               controller: _treatmentCtrl,
//               hintStyle: TextStyle(
//                 fontSize: 12.sp,
//                 color: const Color(0xFF787878),
//               ),
//               fieldFillColor: const Color(0xFFF9FCFF),
//               keyboardType: TextInputType.multiline,
//             ),
//             SizedBox(height: 12.h),
//             CustomFormField(
//               label: "DOCTOR'S NOTES",
//               hint: 'Add instructions, follow-up advice, restrictions...',
//               controller: _notesCtrl,
//               hintStyle: TextStyle(
//                 fontSize: 12.sp,
//                 color: const Color(0xFF787878),
//               ),
//               fieldFillColor: const Color(0xFFF9FCFF),
//               keyboardType: TextInputType.multiline,
//             ),
//             SizedBox(height: 12.h),
//             // Follow-up date picker
//             InkWell(
//               onTap: () async {
//                 final picked = await showDatePicker(
//                   context: context,
//                   initialDate: _followUpDate ?? DateTime.now(),
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime.now().add(const Duration(days: 365)),
//                 );
//                 if (picked != null) {
//                   setState(() {
//                     _followUpDate = picked;
//                     _followUpCtrl.text = DateFormat(
//                       'yyyy-MM-dd',
//                     ).format(picked);
//                   });
//                 }
//               },
//               child: CustomFormField(
//                 label: 'FOLLOW-UP DATE',
//                 hint: 'mm/dd/yyyy',
//                 controller: _followUpCtrl,
//                 fieldFillColor: const Color(0xFFF9FCFF),
//                 icon: ImageAssets.calender,
//                 suffixIconPath: ImageAssets.data,
//                 widthIcon: 12.w,
//                 heightIcon: 12.h,
//               ),
//             ),
//             SizedBox(height: 25.h),
//             CustomButton(
//               onPressed: () => _submitPrescription(context),
//               height: 45.83.h,
//               width: 130.w,
//               icon: ImageAssets.drft,
//               text: 'Prescribe',
//               textStyle: TextStyle(
//                 fontSize: 11.sp,
//                 fontWeight: FontWeight.w500,
//                 color: ColorApp.textColor,
//               ),
//               buttonColor: Colors.transparent,
//               border: Border.all(color: ColorApp.textColor, width: 1.w),
//             ),
//             SizedBox(height: 50.h),
//           ],
//         ),
//       ),
//     );
//   }
// }
