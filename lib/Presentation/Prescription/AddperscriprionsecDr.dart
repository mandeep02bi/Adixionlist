import 'package:doctor/Presentation/Prescription/widgets/container_medicen.dart';
import 'package:doctor/core/Theme/color_app.dart';
import 'package:doctor/Core/helper/image_assets.dart';
import 'package:doctor/Data/Data_source/Medicine_datasource.dart';
import 'package:doctor/Data/model/medicine_model.dart';
import 'package:doctor/widgets/Add_patient/custom_button.dart';
import 'package:doctor/widgets/Add_patient/custom_section_title.dart';
import 'package:doctor/widgets/Add_patient/custom_text_field.dart';
import 'package:doctor/Presentation/Prescription/widgets/Patien_widget.dart';
import 'package:doctor/Presentation/Prescription/widgets/border_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Addperscriprionsecdr extends StatefulWidget {
  const Addperscriprionsecdr({super.key});

  @override
  State<Addperscriprionsecdr> createState() => _AddperscriprionsecdrState();
}

class _AddperscriprionsecdrState extends State<Addperscriprionsecdr> {
  late Future<List<MedicineModel>> _medicinesFuture;

  @override
  void initState() {
    super.initState();
    _medicinesFuture = _loadMedicines();
  }

  Future<List<MedicineModel>> _loadMedicines() async {
    try {
      return await MedicineDatabase.instance.getAllMedicines();
    } catch (e) {
      debugPrint('Medicines load error: $e');
      return [];
    }
  }

  void _refreshData() {
    setState(() {
      _medicinesFuture = _loadMedicines();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0.w),
      child: SingleChildScrollView(
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
            SizedBox(height: 8.h),
            const PatientWidgets(),
            SizedBox(height: 16.h),

            CustomFormField(
              label: 'DIAGNOSIS',
              hint: 'Viral Fever & Throat Infection',
              fieldFillColor: const Color(0xFFF9FCFF),
              icon: ImageAssets.stethoscope,
              widthIcon: 18.w,
              heightIcon: 18.h,
            ),
            SizedBox(height: 16.h),

            CustomSectionTitle(
              icon: ImageAssets.drugs,
              title: 'MEDICINES',
              textStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: ColorApp.labelColor,
              ),
              widthIcon: 20.w,
              heightIcon: 20.h,
            ),
            SizedBox(height: 12.h),

            FutureBuilder<List<MedicineModel>>(
              future: _medicinesFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final medicines = snapshot.data ?? [];

                if (medicines.isEmpty) {
                  return _buildEmptyState();
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: medicines.length,
                  itemBuilder: (context, index) {
                    final med = medicines[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FCFF),
                        borderRadius: BorderRadius.circular(25.r),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.1),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(ImageAssets.baneg, width: 30.w, height: 30.h),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        await MedicineDatabase.instance.deleteMedicine(med.id!);
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
                                            text: "Dosage: ",
                                            style: TextStyle(
                                              color: Colors.purple,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "${med.qty} tablet",
                                            style: TextStyle(
                                              color: const Color(0xFF64748B),
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20.w),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 14.r,
                                          color: const Color(0xFF4DB6AC),
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          med.frequency,
                                          style: TextStyle(
                                            color: const Color(0xFF64748B),
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.h),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          size: 14.r,
                                          color: const Color(0xFF4DB6AC),
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          "${med.noOfDays} days",
                                          style: TextStyle(
                                            color: const Color(0xFF64748B),
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 25.w),
                                    Expanded(
                                      child: Text(
                                        med.instruction,
                                        style: TextStyle(
                                          color: const Color(0xFF64748B),
                                          fontSize: 13.sp,
                                        ),
                                        overflow: TextOverflow.ellipsis,
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
            ContainerMedicen(showMedicineFields: true, onAdded: _refreshData),
            SizedBox(height: 25.h),
            CustomButton(
              onPressed: () {},
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
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.all(2.0.r),
      child: DashedBorderContainer(
        child: Container(
          height: 154.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorApp.scaffoldColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageAssets.drugs, width: 40.w, height: 40.h),
              SizedBox(height: 6.h),
              Text(
                'No medicines added yet',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorApp.gery2,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Tap below to add medicines',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorApp.gery1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}