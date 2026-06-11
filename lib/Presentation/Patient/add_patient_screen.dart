import 'package:doctor/Core/Theme/color_app.dart';
import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Core/Bloc/Add_patient_bloc.dart';
import 'package:doctor/Core/networking/network_error_navigator.dart';
import 'package:doctor/Core/networking/error_handler.dart';
import 'package:doctor/Core/networking/api_erro_model.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_request_body.dart';
import 'package:doctor/Presentation/Patient/add_patient_screen_address_and_location.dart';
import 'package:doctor/Presentation/Prescription/AddperscriptionfirstDr.dart';
import 'package:doctor/Presentation/Prescription/cubit/prescription_cubit.dart';
import 'package:doctor/widgets/Add_patient/custom_button.dart';
import 'package:doctor/widgets/Add_patient/custom_gender_selection.dart';
import 'package:doctor/widgets/Add_patient/custom_header_widgets.dart';
import 'package:doctor/widgets/Add_patient/custom_section_title.dart';
import 'package:doctor/widgets/Add_patient/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

String? selectedBloodGroup;
final List<String> bloodGroups = [
  'A+',
  'A-',
  'B+',
  'B-',
  'O+',
  'O-',
  'AB+',
  'AB-',
];

class _AddPatientScreenState extends State<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();

  String selectedGender = "Male";

  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _middleNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageCtrl = TextEditingController();
  final TextEditingController _streetCtrl = TextEditingController();
  final TextEditingController _cityCtrl = TextEditingController();
  final TextEditingController _stateCtrl = TextEditingController();
  final TextEditingController _zipCodeCtrl = TextEditingController();

  static const String backgroundImagePath =
      'assets/images/background/05_Home screen.jpg';

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _middleNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _dobController.dispose();
    _ageCtrl.dispose();
    _streetCtrl.dispose();
    _cityCtrl.dispose();
    _stateCtrl.dispose();
    _zipCodeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddPatientBloc>(),
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF2F5),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const CustomHeaderWidgets(),
                Expanded(
                  child: BlocListener<AddPatientBloc, AddPatientState>(
                    listener: (context, state) {
                      if (state is AddPatientSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.response.message),
                            backgroundColor: Colors.green.shade600,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );

                        final patientData = state.response.data;

                        if (patientData != null) {
                          final patient = PatientModel(
                            patientCode: patientData.patientCode,
                            firstName: patientData.firstName,
                            middleName: patientData.middleName,
                            lastName: patientData.lastName,
                            phone: patientData.phone,
                            gender: selectedGender,
                            age: int.tryParse(_ageCtrl.text.trim()),
                            bloodGroup: selectedBloodGroup,
                            city: _cityCtrl.text.trim(),
                            createdAt: null,
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (_) => getIt<PrescriptionCubit>(),
                                child: Addperscriptionfirstdr(patient: patient),
                              ),
                            ),
                          );
                        }
                      } else if (state is AddPatientError) {
                        // Check if it's a network error
                        final isNetworkError =
                            state.statusCode == ResponseCode.CONNECT_TIMEOUT ||
                            state.statusCode == ResponseCode.RECIEVE_TIMEOUT ||
                            state.statusCode == ResponseCode.SEND_TIMEOUT ||
                            state.statusCode ==
                                ResponseCode.NO_INTERNET_CONNECTION ||
                            state.statusCode == ResponseCode.DEFAULT;

                        if (isNetworkError) {
                          // Navigate to home page for network errors
                          NetworkErrorNavigator.handleNetworkError(
                            context,
                            ApiErroModel(
                              status: false,
                              statusCode: state.statusCode,
                              message: state.message,
                              data: null,
                            ),
                            navigateToHome: true,
                            showSnackbar: true,
                          );
                        } else {
                          // Just show error for non-network errors
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red.shade600,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      }
                    },
                    child: Stack(
                      children: [
                        _buildForm(),
                        BlocBuilder<AddPatientBloc, AddPatientState>(
                          builder: (context, state) {
                            if (state is AddPatientLoading) {
                              return Container(
                                color: Colors.black26,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF0F6E56),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  //  FORM
  Widget _buildForm() {
    return Builder(
      builder: (context) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSectionTitle(
                  icon: 'assets/images/Icons/Patient/Add/add.png',
                  title: 'Personal Information',
                  widthIcon: 14.w,
                  heightIcon: 18.h,
                ),
                SizedBox(height: 25.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomFormField(
                        label: "First Name",
                        hint: "Rishabh",
                        icon: 'assets/images/Icons/Patient/Add/e.png',
                        widthIcon: 16.w,
                        heightIcon: 16.h,
                        textColor: const Color(0xFF888A8E),
                        controller: _firstNameCtrl,
                        validator: (v) =>
                            v!.isEmpty ? "Please enter first name" : null,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: CustomFormField(
                        label: "Middle Name",
                        icon: 'assets/images/Icons/Patient/Add/e.png',
                        hint: "Kumar",
                        textColor: const Color(0xFF888A8E),
                        controller: _middleNameCtrl,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                CustomFormField(
                  label: "Last Name",
                  icon: 'assets/images/Icons/Patient/Add/e.png',
                  hint: "Singh",
                  textColor: const Color(0xFF888A8E),
                  controller: _lastNameCtrl,
                  validator: (v) =>
                      v!.isEmpty ? "Please enter last name" : null,
                ),
                SizedBox(height: 20.h),
                CustomFormField(
                  label: "Phone Number",
                  hint: "+91 98765 43210",
                  icon: 'assets/images/Icons/Patient/Add/p.png',
                  heightIcon: 16.h,
                  widthIcon: 16.w,
                  textColor: const Color(0xFF888A8E),
                  keyboardType: TextInputType.phone,
                  controller: _phoneCtrl,
                  validator: (v) =>
                      v!.length < 10 ? "Invalid phone number" : null,
                ),
                SizedBox(height: 20.h),
                CustomFormField(
                  label: "Email Address",
                  hint: "patient@email.com",
                  icon: 'assets/images/Icons/Patient/Add/m.png',
                  heightIcon: 14.h,
                  widthIcon: 16.w,
                  textColor: const Color(0xFF888A8E),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailCtrl,
                  validator: (v) => v!.isEmpty ? "Please enter email" : null,
                ),
                SizedBox(height: 20.h),
                CustomFormField(
                  label: "Date of Birth",
                  hint: "mm/dd/yyyy",
                  icon: 'assets/images/Icons/Patient/Add/do.png',
                  isDateField: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      _dobController.text =
                          "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
                    }
                  },
                  keyboardType: TextInputType.datetime,
                  widthIcon: 14.w,
                  heightIcon: 17.h,
                  suffixIcon: Icons.calendar_month,
                  textColor: Colors.black,
                  controller: _dobController,
                  validator: (v) => v!.isEmpty ? "Please enter DOB" : null,
                ),
                SizedBox(height: 20.h),
                CustomFormField(
                  label: "Age",
                  hint: "21",
                  icon: 'assets/images/Icons/Patient/Add/m.png',
                  heightIcon: 14.h,
                  widthIcon: 16.w,
                  textColor: const Color(0xFF888A8E),
                  keyboardType: TextInputType.number,
                  controller: _ageCtrl,
                  validator: (v) => v!.isEmpty ? "Please enter Age" : null,
                ),
                SizedBox(height: 20.h),
                Text(
                  "GENDER",
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomGenderSelection(
                  initialValue: selectedGender,
                  onGenderChanged: (val) {
                    setState(() {
                      selectedGender = val;
                    });
                  },
                ),
                SizedBox(height: 20.h),
                CustomSectionTitle(
                  title: 'Blood group',
                  textStyle: TextStyle(
                    fontSize: 12.sp,
                    color: ColorApp.labelColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                _buildBloodGroupDropdown(),
                AddPatientScreenAddressAndLocation(
                  streetController: _streetCtrl,
                  cityController: _cityCtrl,
                  stateController: _stateCtrl,
                  zipCodeController: _zipCodeCtrl,
                ),
                SizedBox(height: 40.h),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String? dobFormatted;
                      if (_dobController.text.isNotEmpty) {
                        try {
                          final parts = _dobController.text.split('/');
                          if (parts.length == 3) {
                            final month = parts[0].padLeft(2, '0');
                            final day = parts[1].padLeft(2, '0');
                            final year = parts[2];
                            dobFormatted = '$year-$month-$day';
                          }
                        } catch (_) {}
                      }

                      final requestBody = PatientRequestBody(
                        firstName: _firstNameCtrl.text.trim(),
                        middleName: _middleNameCtrl.text.trim().isNotEmpty
                            ? _middleNameCtrl.text.trim()
                            : null,
                        lastName: _lastNameCtrl.text.trim(),
                        phone: _phoneCtrl.text.trim().isNotEmpty
                            ? _phoneCtrl.text.trim()
                            : null,
                        email: _emailCtrl.text.trim().isNotEmpty
                            ? _emailCtrl.text.trim()
                            : null,
                        dateOfBirth: dobFormatted,
                        age: int.tryParse(_ageCtrl.text.trim()),
                        gender: selectedGender,
                        bloodGroup: selectedBloodGroup,
                        streetAddress: _streetCtrl.text.trim().isNotEmpty
                            ? _streetCtrl.text.trim()
                            : null,
                        city: _cityCtrl.text.trim().isNotEmpty
                            ? _cityCtrl.text.trim()
                            : null,
                        state: _stateCtrl.text.trim().isNotEmpty
                            ? _stateCtrl.text.trim()
                            : null,
                        zipCode: _zipCodeCtrl.text.trim().isNotEmpty
                            ? _zipCodeCtrl.text.trim()
                            : null,
                      );
                      context.read<AddPatientBloc>().add(
                        SubmitPatient(requestBody),
                      );
                    }
                  },
                  text: 'Continue',
                  icon: Icons.arrow_forward,
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBloodGroupDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: "Select Blood Group",
        prefixIcon: Padding(
          padding: EdgeInsets.all(10.w),
          child: Image.asset(
            'assets/images/Icons/Patient/Add/Blood.png',
            width: 18.w,
            height: 18.h,
            color: Colors.redAccent,
          ),
        ),
        filled: true,
        fillColor: const Color(0xFFF8FEFB),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF0F6E56)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF0F6E56), width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF0F6E56)),
        ),
      ),
      initialValue: selectedBloodGroup,
      items: bloodGroups
          .map(
            (group) => DropdownMenuItem(
              value: group,
              child: Text(group, style: TextStyle(fontSize: 14.sp)),
            ),
          )
          .toList(),
      onChanged: (val) => setState(() => selectedBloodGroup = val),
    );
  }
}
