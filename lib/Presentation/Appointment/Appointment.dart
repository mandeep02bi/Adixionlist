import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Core/helper/token_storage_service.dart';
import 'package:doctor/Presentation/Appointment/data/models/appointment_request_body.dart';
import 'package:doctor/Presentation/Appointment/logic/appointment_cubit.dart';
import 'package:doctor/Presentation/Appointment/logic/appointment_state.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
import 'package:doctor/widgets/Book_appointment.dart/Datecart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Appointment extends StatefulWidget {
  final PatientModel patient;

  const Appointment({super.key, required this.patient});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  int selectedTimeIndex = -1;
  DateTime selectedDate = DateTime.now();

  final times = [
    "09:00",
    "09:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "14:00",
    "14:30",
    "15:00",
    "15:30",
    "14:00",
    "14:30",
  ];

  final displayTimes = [
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
  ];

  late List<DateTime> dateList;

  @override
  void initState() {
    // Generate next 5 days
    dateList = List.generate(
      5,
      (index) => DateTime.now().add(Duration(days: index)),
    );
    super.initState();
  }

  void bookAppointment(BuildContext context) async {
    if (selectedTimeIndex == -1) {
      Get.snackbar(
        "Required",
        "Please select a time slot first.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    final timeStr = times[selectedTimeIndex];

    // Get logged in doctor code
    final doctorCode =
        await getIt<TokenStorageService>().getUserCode() ?? "DR0001";

    final body = AppointmentRequestBody(
      patientCode: widget.patient.patientCode,
      doctorCode: doctorCode,
      appointmentDate: dateStr,
      appointmentTime: timeStr,
      purpose: "Consultation",
      notes: "Booked via mobile",
    );

    if (context.mounted) {
      context.read<AppointmentCubit>().bookAppointment(body);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initials avatar
    String initials = "PT";
    if (widget.patient.firstName.isNotEmpty &&
        widget.patient.lastName.isNotEmpty) {
      initials =
          "${widget.patient.firstName[0].toUpperCase()}${widget.patient.lastName[0].toUpperCase()}";
    }

    return BlocProvider<AppointmentCubit>(
      create: (context) => getIt<AppointmentCubit>(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4FA3A5), Color(0xFF7B3FCF)],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Builder(
            builder: (context) {
              return BlocListener<AppointmentCubit, AppointmentState>(
                listener: (context, state) {
                  state.maybeWhen(
                    success: (data) {
                      Get.snackbar(
                        "Success",
                        "Appointment booked successfully!",
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );

                      Navigator.pop(context, true);
                    },
                    error: (errorMsg) {
                      Get.snackbar(
                        "Error Booking",
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
                        OrientationBuilder(
                          builder: (context, orientation) {
                            return Stack(
                              children: [
                                Image.asset(
                                  "assets/images/Header/header.png",
                                  height: orientation == Orientation.portrait
                                      ? 110.h
                                      : 70.h,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                                Positioned(
                                  top: orientation == Orientation.portrait
                                      ? 40.h
                                      : 25.h,
                                  left: 15.w,
                                  child: CircleAvatar(
                                    radius: orientation == Orientation.portrait
                                        ? 22.r
                                        : 18.r,
                                    backgroundColor: Colors.white24,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Image.asset(
                                        "assets/images/Icons/Patient/Frame.png",
                                        height:
                                            orientation == Orientation.portrait
                                            ? 22.h
                                            : 18.h,
                                        width:
                                            orientation == Orientation.portrait
                                            ? 22.w
                                            : 18.w,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: orientation == Orientation.portrait
                                      ? 45.h
                                      : 30.h,
                                  left: 80.w,
                                  child: Text(
                                    "Book An appointment",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          orientation == Orientation.portrait
                                          ? 20.sp
                                          : 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        /// BODY
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.r),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F5F7),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30.r),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "PATIENT",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  _patientCard(initials),
                                  SizedBox(height: 20.h),
                                  Text(
                                    "Select Date",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  _dateSelector(),
                                  SizedBox(height: 20.h),
                                  Text(
                                    "Select Time",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  _timeGrid(),
                                  SizedBox(height: 30.h),
                                  GestureDetector(
                                    onTap: () => bookAppointment(context),
                                    child: _bookButton(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Loader Overlay
                    BlocBuilder<AppointmentCubit, AppointmentState>(
                      builder: (context, state) {
                        final isLoading = state.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        );
                        if (isLoading) {
                          return Container(
                            color: Colors.black.withOpacity(0.3),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// ---------- PATIENT CARD ----------
  Widget _patientCard(String initials) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.r,
            backgroundColor: const Color(0xFF4FA3A5),
            child: Text(
              initials,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.patient.fullName,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
              Text(
                "${widget.patient.patientCode}.Age ${widget.patient.age ?? 0} Years (${widget.patient.gender ?? 'Unspecified'})",
                style: TextStyle(color: Colors.grey, fontSize: 13.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ---------- DATE SELECTOR ----------
  Widget _dateSelector() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.green, size: 20.r),
                  SizedBox(width: 10.w),
                  Text(
                    DateFormat('EEEE, MMMM dd, yyyy').format(selectedDate),
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, size: 16.r),
            ],
          ),
        ),
        SizedBox(height: 12.h),

        /// Horizontal Dates
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: dateList.map((date) {
              final isSelected =
                  selectedDate.year == date.year &&
                  selectedDate.month == date.month &&
                  selectedDate.day == date.day;

              final dayStr = DateFormat('E').format(date);
              final dateNum = DateFormat('d').format(date);

              return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  child: DateCard(
                    day: dayStr,
                    date: dateNum,
                    active: isSelected,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  /// ---------- TIME GRID ----------
  Widget _timeGrid() {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Padding(
          padding: const EdgeInsets.only(top: 0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayTimes.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 3 : 5,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: orientation == Orientation.portrait ? 2.5 : 3.0,
            ),
            itemBuilder: (context, index) {
              final isSelected = selectedTimeIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTimeIndex = index;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [Color(0xFF7B3FCF), Color(0xFF9C27B0)],
                          )
                        : null,
                    color: isSelected ? null : Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    displayTimes[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _bookButton() {
    return Container(
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
          "Book Appointment",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
