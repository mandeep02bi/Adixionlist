import 'package:doctor/Presentation/Prescription/widgets/container_medicen.dart';
import 'package:doctor/core/Theme/color_app.dart';
import 'package:doctor/Core/helper/image_assets.dart';
import 'package:doctor/Data/Data_source/Medicine_datasource.dart';
import 'package:doctor/Data/model/medicine_model.dart';
import 'package:doctor/widgets/Add_patient/custom_button.dart';
import 'package:doctor/widgets/Add_patient/custom_section_title.dart';
import 'package:doctor/widgets/Add_patient/custom_text_field.dart';
import 'package:doctor/Presentation/Prescription/widgets/Patien_widget.dart';
import 'package:doctor/Presentation/Prescription/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Addperscriptionthirddr extends StatefulWidget {
  final VoidCallback? onPrescribe;
  const Addperscriptionthirddr({super.key, this.onPrescribe});

  @override
  State<Addperscriptionthirddr> createState() => _AddperscriptionthirddrState();
}

class _AddperscriptionthirddrState extends State<Addperscriptionthirddr> {
  late Future<List<MedicineModel>> _labTestsFuture;

  @override
  void initState() {
    super.initState();
    _labTestsFuture = MedicineDatabase.instance.getAllLabTests();
  }

  void _refreshData() {
    setState(() {
      _labTestsFuture = MedicineDatabase.instance.getAllLabTests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PATIENT',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF808080),
                      letterSpacing: 1.w,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  const PatientWidgets(),
                  SizedBox(height: 12.h),
                  CustomFormField(
                    label: 'DIAGNOSIS By Staff',
                    hint: 'Viral Fever & Throat Infection',
                    fieldFillColor: const Color(0xFFF9FCFF),
                    icon: ImageAssets.stethoscope,
                    widthIcon: 18.w,
                    heightIcon: 18.h,
                  ),
                  SizedBox(height: 15.h),
                  CustomSectionTitle(
                    icon: ImageAssets.lab,
                    title: 'Lab Test',
                    widthIcon: 25.w,
                    heightIcon: 23.h,
                  ),
                  SizedBox(height: 10.h),
                  FutureBuilder<List<MedicineModel>>(
                    future: _labTestsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final labTests = snapshot.data ?? [];
                      if (labTests.isEmpty) {
                        return EmptyState(
                          icon: ImageAssets.lab,
                          subtitle: 'Tap below to add Lab Test',
                          title: 'No Lab Test add yet',
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: labTests.length,
                        itemBuilder: (context, index) {
                          final med = labTests[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9FCFF),
                              borderRadius: BorderRadius.circular(25.r),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.1),
                              ),
                            ),
                            margin: EdgeInsets.only(bottom: 12.h),
                            padding: EdgeInsets.all(16.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  ImageAssets.baneg,
                                  width: 30.w,
                                  height: 30.h,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              med.medicineName,
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF333333),
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              await MedicineDatabase.instance
                                                  .deleteMedicine(med.id!);
                                              _refreshData();
                                            },
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: const Color(0xFFE57373),
                                              size: 24.r,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.h),
                                      Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "How: ${med.instruction}",
                                                  style: TextStyle(
                                                    color: Colors.purple,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 15.h),
                  ContainerMedicen(
                    title: 'Add Lab Test',
                    nameOf: 'Name of Lab Test',
                    name: 'Lab Test',
                    showMedicineFields: false,
                    onAdded: _refreshData,
                  ),
                  SizedBox(height: 25.h),
                  CustomButton(
                    onPressed: () => widget.onPrescribe?.call(),
                    height: 45.h,
                    width: 130.w,
                    assetIcon: ImageAssets.drft,
                    text: 'Prescribe',
                    textStyle: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorApp.textColor,
                    ),
                    buttonColor: Colors.transparent,
                    border: Border.all(color: ColorApp.textColor, width: 1.w),
                  ),
                  SizedBox(height: 60.h),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

