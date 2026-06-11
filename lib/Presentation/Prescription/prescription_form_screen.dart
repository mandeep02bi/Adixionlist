import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Core/services/prescription_pdf_service.dart';
import 'package:doctor/Data/model/lab_test_request_body.dart';
import 'package:doctor/Data/model/medicine_request_body.dart';
import 'package:doctor/Data/model/prescription_request_body.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
import 'package:doctor/Presentation/Prescription/cubit/prescription_cubit.dart';
import 'package:doctor/Presentation/Prescription/cubit/prescription_state.dart';
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
              backgroundColor: const Color(0xff1C034F),

              body: Stack(
                children: [
                  /// MAIN BODY
                  SafeArea(
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),

                        /// HEADER
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 18.r,
                                backgroundColor: Colors.white24,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                    size: 16.sp,
                                  ),
                                ),
                              ),

                              SizedBox(width: 12.w),

                              Text(
                                "Write Prescription",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const Spacer(),

                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                child: Text(
                                  "12 Mar 2026",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 18.h),

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
    return Column(
      children: [
        _field("Diagnosis By Staff", diagnosisByStaffController),
        _field("Diagnosis", diagnosisController),
        _field("Findings", findingsController),

        Row(
          children: [
            Expanded(child: _field("Height", heightController)),

            SizedBox(width: 10.w),

            Expanded(child: _field("Weight", weightController)),
          ],
        ),

        Row(
          children: [
            Expanded(child: _field("BP", bloodPressureController)),

            SizedBox(width: 10.w),

            Expanded(child: _field("Hemoglobin", hemoglobinController)),
          ],
        ),

        _field("Temperature", temperatureController),
        _field("Chief Complaint", chiefComplaintController),
        _field("History", historyController),
        _field("Treatment Advice", treatmentController),

        Row(
          children: [
            Expanded(child: _field("SPO2", spo2Controller)),

            SizedBox(width: 10.w),

            Expanded(child: _field("Respiratory", respirationController)),
          ],
        ),

        _field("Doctor Notes", notesController),
        _field("Follow-Up Date", followUpDateController),
      ],
    );
  }

  /// MEDICINE UI
  Widget _medicineUI() {
    return Column(
      children: [
        _field("Medicine Name", medicineNameController),

        Row(
          children: [
            Expanded(child: _field("Frequency", frequencyController)),

            SizedBox(width: 10.w),

            Expanded(child: _field("Route", routeController)),
          ],
        ),

        Row(
          children: [
            Expanded(child: _field("No Of Days", daysController)),

            SizedBox(width: 10.w),

            Expanded(child: _field("Qty", qtyController)),
          ],
        ),

        _field("Instruction", instructionController),

        SizedBox(height: 10.h),

        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  medicines.add(
                    MedicineRequestBody(
                      name: medicineNameController.text,
                      frequency: frequencyController.text,
                      noOfDays: daysController.text,
                      routeForm: routeController.text,
                      instructions: instructionController.text,
                      totalQuantity: qtyController.text,
                    ),
                  );

                  medicineNameController.clear();
                  frequencyController.clear();
                  daysController.clear();
                  routeController.clear();
                  instructionController.clear();
                  qtyController.clear();

                  setState(() {});
                },

                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xff57D3BE),

                  side: const BorderSide(color: Color(0xff57D3BE)),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),

                child: const Text("Save and Add"),
              ),
            ),

            SizedBox(width: 10.w),

            Expanded(
              child: OutlinedButton(
                onPressed: () {},

                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xff57D3BE),

                  side: const BorderSide(color: Color(0xff57D3BE)),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),

                child: const Text("Choose Template"),
              ),
            ),
          ],
        ),

        SizedBox(height: 15.h),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: medicines.length,
          itemBuilder: (context, index) {
            final medicine = medicines[index];

            return Container(
              margin: EdgeInsets.only(bottom: 10.h),

              padding: EdgeInsets.all(12.w),

              decoration: BoxDecoration(
                color: const Color(0xffF7F8FA),

                borderRadius: BorderRadius.circular(14.r),
              ),

              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18.r,
                    backgroundColor: const Color(0xffF7C948),

                    child: Icon(
                      Icons.medication,
                      size: 16.sp,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(width: 10.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          medicine.name,

                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 4.h),

                        Text(
                          "${medicine.frequency} • "
                          "${medicine.noOfDays} Days",

                          style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  /// LAB TEST UI
  Widget _labTestUI() {
    return Column(
      children: [
        _field("Lab Test Name", labTestController),
        _field("Additional Comments", labCommentController),

        SizedBox(height: 10.h),

        Row(
          children: [
            Expanded(
              child: OutlinedButton(
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

                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xff57D3BE),

                  side: const BorderSide(color: Color(0xff57D3BE)),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),

                child: const Text("Save and Add"),
              ),
            ),

            SizedBox(width: 10.w),

            Expanded(
              child: OutlinedButton(
                onPressed: () {},

                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xff57D3BE),

                  side: const BorderSide(color: Color(0xff57D3BE)),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),

                child: const Text("Choose Template"),
              ),
            ),
          ],
        ),

        SizedBox(height: 15.h),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: labTests.length,
          itemBuilder: (context, index) {
            final lab = labTests[index];

            return Container(
              margin: EdgeInsets.only(bottom: 10.h),

              padding: EdgeInsets.all(12.w),

              decoration: BoxDecoration(
                color: const Color(0xffF7F8FA),

                borderRadius: BorderRadius.circular(14.r),
              ),

              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18.r,
                    backgroundColor: const Color(0xff57D3BE),

                    child: Icon(
                      Icons.science,
                      size: 16.sp,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(width: 10.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          lab.testName,

                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 4.h),

                        Text(
                          lab.additionalComments ?? "",

                          style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                        ),
                      ],
                    ),
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
