import 'dart:convert';

import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Core/helper/image_assets.dart';
import 'package:doctor/Core/services/prescription_pdf_service.dart';
import 'package:doctor/Core/widgets/custom_button.dart';
import 'package:doctor/Data/model/lab_test_request_body.dart';
import 'package:doctor/Data/model/medicine_request_body.dart';
import 'package:doctor/Data/model/prescription_request_body.dart';
import 'package:doctor/Presentation/MyTemplate/my_template.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
import 'package:doctor/Presentation/Prescription/cubit/prescription_cubit.dart';
import 'package:doctor/Presentation/Prescription/cubit/prescription_state.dart';
import 'package:doctor/Presentation/Prescription/widgets/custom_hader_preview.dart';
import 'package:doctor/Presentation/Prescription/widgets/custom_tab_bar.dart';
import 'package:doctor/Presentation/Prescription/widgets/custom_text_form_field.dart';
import 'package:doctor/Presentation/Prescription/widgets/empty_state.dart';
import 'package:doctor/Presentation/Prescription/widgets/medicine_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_filex/open_filex.dart';

class PrescriptionFormScreen extends StatefulWidget {
  final PatientModel patient;

  const PrescriptionFormScreen({super.key, required this.patient});

  @override
  State<PrescriptionFormScreen> createState() => _PrescriptionFormScreenState();
}

class _PrescriptionFormScreenState extends State<PrescriptionFormScreen> {
  int selectedTab = 0;

  /// CASE HISTORY CONTROLLERS
  final diagnosisByStaffController = TextEditingController();
  final diagnosisController = TextEditingController();
  final findingsController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final temperatureController = TextEditingController();
  final spo2Controller = TextEditingController();
  final respirationController = TextEditingController();
  final treatmentController = TextEditingController();
  final doctorNotesController = TextEditingController();
  final pulseController = TextEditingController();
  final bloodPressureController = TextEditingController();
  final bloodSugarController = TextEditingController();
  final hemoglobinController = TextEditingController();
  final allergyController = TextEditingController();
  final chiefComplaintController = TextEditingController();
  final historyController = TextEditingController();
  final endNoteController = TextEditingController();
  final notesController = TextEditingController();
  final followUpDateController = TextEditingController();

  /// MEDICINE CONTROLLERS
  final medicineNameController = TextEditingController();
  final frequencyController = TextEditingController();
  final daysController = TextEditingController();
  final routeController = TextEditingController();
  final instructionController = TextEditingController();
  final qtyController = TextEditingController();

  /// LAB TEST CONTROLLERS
  final labTestController = TextEditingController();
  final labCommentController = TextEditingController();

  /// LOCAL LISTS
  final List<MedicineRequestBody> medicines = [];
  final List<LabTestRequestBody> labTests = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PrescriptionCubit>(),
      child: Builder(
        builder: (context) {
          return BlocListener<PrescriptionCubit, PrescriptionState>(
            listener: (context, state) async {
              if (state is PrescriptionLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  useRootNavigator: true,
                  builder: (_) {
                    return const Center(child: CircularProgressIndicator());
                  },
                );
              } else if (state is PrescriptionSuccess) {
                /// CLOSE ONLY LOADER
                Navigator.of(context, rootNavigator: true).pop();

                final body = PrescriptionRequestBody(
                  patientCode: widget.patient.patientCode,
                  temperature: temperatureController.text,
                  height: heightController.text,
                  weight: weightController.text,
                  pulse: pulseController.text,
                  bloodPressure: bloodPressureController.text,
                  bloodSugar: bloodSugarController.text,
                  hemoglobin: hemoglobinController.text,
                  spo2: spo2Controller.text,
                  respirationRate: respirationController.text,
                  allergy: allergyController.text,
                  chiefComplaint: chiefComplaintController.text,
                  history: historyController.text,
                  findings: findingsController.text,
                  diagnosis: diagnosisController.text,
                  treatmentAdvice: treatmentController.text,
                  endNote: endNoteController.text,
                  notes: notesController.text,
                  followUpDate: followUpDateController.text,
                  prescriptionDate: DateTime.now().toString(),
                );

                final file = await PrescriptionPdfService.generate(
                  patient: widget.patient,
                  prescription: body,
                  medicines: medicines,
                  labTests: labTests,
                );

                await OpenFilex.open(file.path);

                if (!mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Prescription PDF Generated Successfully"),
                  ),
                );
              } else if (state is PrescriptionError) {
                /// CLOSE ONLY LOADER
                Navigator.of(context, rootNavigator: true).pop();

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },

            child: Scaffold(
              resizeToAvoidBottomInset: true,

              // backgroundColor: const Color(0xff1C034F),
              body: Stack(
                children: [
                  /// MAIN BODY
                  SafeArea(
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),

                        /// HEADER
                        CustomHaderPreview(title: "Write Prescription"),
                        SizedBox(height: 10.h),

                        /// MAIN CONTAINER
                        Expanded(
                          child: Container(
                            width: double.infinity,

                            decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32.r),
                                topRight: Radius.circular(32.r),
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 20,
                                  offset: const Offset(0, -4),
                                ),
                              ],
                            ),

                            child: Column(
                              children: [
                                SizedBox(height: 16.h),

                                /// TABS
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 18.w,
                                  ),
                                  child: Row(
                                    children: [
                                      _toggleButton(
                                        title: "Case History",
                                        index: 0,
                                      ),

                                      SizedBox(width: 10.w),

                                      _toggleButton(title: "Medical", index: 1),

                                      SizedBox(width: 10.w),

                                      _toggleButton(
                                        title: "Lab Test",
                                        index: 2,
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 18.h),

                                /// PATIENT CARD
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),

                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 10.h,
                                  ),

                                  decoration: BoxDecoration(
                                    color: const Color(0xffF7F8FA),

                                    borderRadius: BorderRadius.circular(14.r),

                                    border: Border.all(
                                      color: const Color(0xffE8ECF4),
                                    ),
                                  ),

                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 18.r,
                                        backgroundColor: const Color(
                                          0xff4E8DF5,
                                        ),

                                        child: Text(
                                          widget.patient.firstName[0],

                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 10.w),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          children: [
                                            Text(
                                              "${widget.patient.firstName} "
                                              "${widget.patient.lastName}",

                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xff1B1D28),
                                              ),
                                            ),

                                            SizedBox(height: 2.h),

                                            Text(
                                              widget.patient.patientCode,

                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 20.sp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 16.h),

                                /// BODY
                                Expanded(
                                  child: SingleChildScrollView(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                    ),

                                    child: Column(
                                      children: [
                                        if (selectedTab == 0) _caseHistoryUI(),

                                        if (selectedTab == 1) _medicineUI(),

                                        if (selectedTab == 2) _labTestUI(),

                                        SizedBox(height: 100.h),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// PRESCRIBE BUTTON
                  Positioned(
                    bottom: 20.h,
                    left: 70.w,
                    right: 70.w,

                    child: SizedBox(
                      height: 42.h,

                      child: ElevatedButton(
                        onPressed: () async {
                          final cubit = context.read<PrescriptionCubit>();

                          final body = PrescriptionRequestBody(
                            patientCode: widget.patient.patientCode,

                            temperature: temperatureController.text,

                            height: heightController.text,

                            weight: weightController.text,

                            pulse: pulseController.text,

                            bloodPressure: bloodPressureController.text,

                            bloodSugar: bloodSugarController.text,

                            hemoglobin: hemoglobinController.text,

                            spo2: spo2Controller.text,

                            respirationRate: respirationController.text,

                            allergy: allergyController.text,

                            chiefComplaint: chiefComplaintController.text,

                            history: historyController.text,

                            findings: findingsController.text,

                            diagnosis: diagnosisController.text,

                            treatmentAdvice: treatmentController.text,

                            endNote: endNoteController.text,

                            notes: notesController.text,

                            followUpDate: followUpDateController.text,

                            prescriptionDate: DateTime.now().toString(),
                          );

                          await cubit.createFullPrescription(
                            prescriptionBody: body,
                            medicines: medicines,
                            labTests: labTests,
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xff7CDDCB),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),

                        child: Text(
                          "Prescribe",

                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// TOGGLE BUTTON
  Widget _toggleButton({required String title, required int index}) {
    bool isSelected = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },

        child: Column(
          children: [
            Text(
              title,

              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,

                color: isSelected ? const Color(0xff1B1D28) : Colors.grey,
              ),
            ),

            SizedBox(height: 8.h),

            AnimatedContainer(
              duration: const Duration(milliseconds: 250),

              height: 2.h,
              width: double.infinity,

              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xff1B1D28)
                    : Colors.transparent,

                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// CASE HISTORY UI
  Widget _caseHistoryUI() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          CustomTextFormField(
            label: "Diagnosis By Staff",
            hint: "Enter diagnosis by staff",
            controller: diagnosisByStaffController,
            fieldFillColor: const Color(0xFFF9FCFF),
          ),

          SizedBox(height: 12.h),

          CustomTextFormField(
            label: "Diagnosis",
            hint: "Enter diagnosis",
            controller: diagnosisController,
            fieldFillColor: const Color(0xFFF9FCFF),
          ),

          SizedBox(height: 12.h),

          CustomTextFormField(
            label: "Findings",
            hint: "Enter findings",
            controller: findingsController,
            fieldFillColor: const Color(0xFFF9FCFF),
          ),

          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  label: "Height",
                  hint: "170",
                  controller: heightController,
                  fieldFillColor: const Color(0xFFF9FCFF),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: CustomTextFormField(
                  label: "Weight",
                  hint: "65",
                  controller: weightController,
                  fieldFillColor: const Color(0xFFF9FCFF),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  label: "Blood Pressure",
                  hint: "120/80",
                  controller: bloodPressureController,
                  fieldFillColor: const Color(0xFFF9FCFF),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: CustomTextFormField(
                  label: "Hemoglobin",
                  hint: "13",
                  controller: hemoglobinController,
                  fieldFillColor: const Color(0xFFF9FCFF),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          CustomTextFormField(
            label: "Temperature",
            hint: "98.6",
            controller: temperatureController,
            fieldFillColor: const Color(0xFFF9FCFF),
          ),

          SizedBox(height: 12.h),

          CustomTextFormField(
            label: "Chief Complaint",
            hint: "Enter chief complaint",
            controller: chiefComplaintController,
            fieldFillColor: const Color(0xFFF9FCFF),
          ),

          SizedBox(height: 12.h),

          CustomTextFormField(
            label: "History",
            hint: "Patient history",
            controller: historyController,
            keyboardType: TextInputType.multiline,
            fieldFillColor: const Color(0xFFF9FCFF),
          ),

          SizedBox(height: 12.h),

          CustomTextFormField(
            label: "Treatment Advice",
            hint: "Treatment advice",
            controller: treatmentController,
            keyboardType: TextInputType.multiline,
            fieldFillColor: const Color(0xFFF9FCFF),
          ),

          SizedBox(height: 12.h),

          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  label: "SPO2",
                  hint: "98%",
                  controller: spo2Controller,
                  fieldFillColor: const Color(0xFFF9FCFF),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: CustomTextFormField(
                  label: "Respiratory",
                  hint: "16",
                  controller: respirationController,
                  fieldFillColor: const Color(0xFFF9FCFF),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          CustomTextFormField(
            label: "Doctor Notes",
            hint: "Add notes",
            controller: notesController,
            keyboardType: TextInputType.multiline,
            fieldFillColor: const Color(0xFFF9FCFF),
          ),

          SizedBox(height: 12.h),

          CustomTextFormField(
            label: "Follow Up Date",
            hint: "YYYY/DD/MM",
            controller: followUpDateController,
            fieldFillColor: const Color(0xFFF9FCFF),
          ),
        ],
      ),
    );
  }

  /// MEDICINE UI

  Widget _medicineUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              CustomTextFormField(
                label: "Medicine Name",
                hint: "Enter medicine name",
                controller: medicineNameController,
                fieldFillColor: const Color(0xFFF9FCFF),
              ),

              SizedBox(height: 12.h),

              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      label: "Frequency",
                      hint: "1x/day",
                      controller: frequencyController,
                      fieldFillColor: const Color(0xFFF9FCFF),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomTextFormField(
                      label: "Route",
                      hint: "Oral",
                      controller: routeController,
                      fieldFillColor: const Color(0xFFF9FCFF),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      label: "No Of Days",
                      hint: "7",
                      controller: daysController,
                      fieldFillColor: const Color(0xFFF9FCFF),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomTextFormField(
                      label: "Qty",
                      hint: "10",
                      controller: qtyController,
                      fieldFillColor: const Color(0xFFF9FCFF),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              CustomTextFormField(
                label: "Instruction",
                hint: "After meals",
                controller: instructionController,
                keyboardType: TextInputType.multiline,
                fieldFillColor: const Color(0xFFF9FCFF),
              ),

              SizedBox(height: 20.h),

              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "Save and Add",
                      buttonColor: Colors.white,
                      border: Border.all(color: const Color(0xff57D3BE)),
                      textStyle: TextStyle(
                        color: const Color(0xff57D3BE),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      onPressed: () {
                        print(
                          "Medicine Name => ${medicineNameController.text}",
                        );
                        print("Frequency => ${frequencyController.text}");
                        print("Route => ${routeController.text}");
                        print("Days => ${daysController.text}");
                        print("Qty => ${qtyController.text}");
                        print("Instruction => ${instructionController.text}");

                        final medicine = MedicineRequestBody(
                          name: medicineNameController.text.trim(),
                          frequency: frequencyController.text.trim(),
                          noOfDays: daysController.text.trim(),
                          routeForm: routeController.text.trim(),
                          instructions: instructionController.text.trim(),
                          totalQuantity: qtyController.text.trim(),
                        );

                        print("MEDICINE JSON => ${medicine.toJson()}");
                        print("ADDING MEDICINE => ${medicine.toJson()}");

                        medicines.add(medicine);

                        medicineNameController.clear();
                        frequencyController.clear();
                        daysController.clear();
                        routeController.clear();
                        instructionController.clear();
                        qtyController.clear();

                        setState(() {});
                      },
                    ),
                  ),

                  SizedBox(width: 10.w),

                  Expanded(
                    child: CustomButton(
                      text: "Choose Template",
                      buttonColor: Colors.white,
                      border: Border.all(color: const Color(0xff57D3BE)),
                      textStyle: TextStyle(
                        color: const Color(0xff57D3BE),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      onPressed: () async {
                        final selectedTemplate = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MyTemplate(type: "Medicine"),
                          ),
                        );

                        if (selectedTemplate != null) {
                          final data = jsonDecode(selectedTemplate);

                          medicineNameController.text =
                              data["medicine_name"] ?? "";

                          frequencyController.text = data["frequency"] ?? "";

                          routeController.text = data["route_form"] ?? "";

                          daysController.text = data["no_of_days"] ?? "";

                          qtyController.text = data["total_quantity"] ?? "";

                          instructionController.text =
                              data["instructions"] ?? "";

                          setState(() {});
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 20.h),

        if (medicines.isEmpty)
          const EmptyState(
            icon: ImageAssets.drugs,
            title: "No Medicines Added",
            subtitle: "Added medicines will appear here",
          ),

        if (medicines.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              final medicine = medicines[index];

              return MedicineCard(
                medicineName: medicine.name,
                dosage: medicine.totalQuantity ?? "",
                frequency: medicine.frequency ?? "",
                days: medicine.noOfDays ?? "",
                onDelete: () {
                  medicines.removeAt(index);
                  setState(() {});
                },
              );
            },
          ),
      ],
    );
  }

  /// LAB TEST UI

  Widget _labTestUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              CustomTextFormField(
                label: "Lab Test Name",
                hint: "Enter lab test name",
                controller: labTestController,
                fieldFillColor: const Color(0xFFF9FCFF),
              ),

              SizedBox(height: 12.h),

              CustomTextFormField(
                label: "Additional Comments",
                hint: "Add notes or instructions",
                controller: labCommentController,
                keyboardType: TextInputType.multiline,
                fieldFillColor: const Color(0xFFF9FCFF),
              ),

              SizedBox(height: 20.h),

              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "Save and Add",
                      buttonColor: Colors.white,
                      border: Border.all(color: const Color(0xff57D3BE)),
                      textStyle: TextStyle(
                        color: const Color(0xff57D3BE),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      onPressed: () {
                        labTests.add(
                          LabTestRequestBody(
                            testName: labTestController.text,
                            additionalComments: labCommentController.text,
                          ),
                        );

                        labTestController.clear();
                        labCommentController.clear();

                        setState(() {});
                      },
                    ),
                  ),

                  SizedBox(width: 10.w),

                  Expanded(
                    child: CustomButton(
                      text: "Choose Template",
                      buttonColor: Colors.white,
                      border: Border.all(color: const Color(0xff57D3BE)),
                      textStyle: TextStyle(
                        color: const Color(0xff57D3BE),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      onPressed: () async {
                        final selectedTemplate = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MyTemplate(type: "Lab Test"),
                          ),
                        );
                        print("Returned Template = $selectedTemplate");

                        if (selectedTemplate != null) {
                          final data = jsonDecode(selectedTemplate);

                          labTestController.text =
                              data["test_name"] ??
                              data["lab_test_name"] ??
                              data["name"] ??
                              "";

                          labCommentController.text =
                              data["additional_comments"] ??
                              data["comments"] ??
                              data["instructions"] ??
                              "";

                          setState(() {});
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 20.h),

        if (labTests.isEmpty)
          const EmptyState(
            icon: ImageAssets.lab,
            title: "No Lab Tests Added",
            subtitle: "Added lab tests will appear here",
          ),

        if (labTests.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: labTests.length,
            itemBuilder: (context, index) {
              final lab = labTests[index];

              return Container(
                margin: EdgeInsets.only(bottom: 12.h),
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18.r,
                      backgroundColor: const Color(0xFFE8F8F4),
                      child: Icon(
                        Icons.science,
                        size: 18.sp,
                        color: const Color(0xff57D3BE),
                      ),
                    ),

                    SizedBox(width: 12.w),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lab.testName,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          SizedBox(height: 4.h),

                          Text(
                            lab.additionalComments ?? "",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        labTests.removeAt(index);
                        setState(() {});
                      },
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  /// COMMON FIELD
  Widget _field(String hint, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),

      child: TextFormField(
        controller: controller,

        style: TextStyle(
          fontSize: 12.sp,
          color: const Color(0xff1B1D28),
          fontWeight: FontWeight.w500,
        ),

        decoration: InputDecoration(
          hintText: hint,

          hintStyle: TextStyle(fontSize: 11.sp, color: Colors.grey),

          filled: true,
          fillColor: const Color(0xffF7F8FA),

          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 12.h,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),

            borderSide: const BorderSide(color: Color(0xffE9EDF5), width: 1),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),

            borderSide: const BorderSide(color: Color(0xff7CDDCB), width: 1.2),
          ),
        ),
      ),
    );
  }
}
