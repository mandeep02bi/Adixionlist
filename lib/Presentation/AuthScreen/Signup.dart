import 'dart:io';
import 'package:doctor/Core/Theme/color_app.dart';
import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Core/widgets/custom_button.dart';
import 'package:doctor/Core/widgets/custom_text_form_field_core.dart';
import 'package:doctor/Presentation/AuthScreen/data/models/register_request_body.dart';
import 'package:doctor/Presentation/AuthScreen/logic/register/register_cubit.dart';
import 'package:doctor/Presentation/AuthScreen/logic/register/register_state.dart';
import 'package:doctor/Presentation/AuthScreen/widgets/password_field.dart';
import 'package:doctor/Presentation/AuthScreen/widgets/role_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupSC extends StatefulWidget {
  const SignupSC({super.key});

  @override
  State<SignupSC> createState() => _SignupSCState();
}

class _SignupSCState extends State<SignupSC> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  String _selectedRole = 'Doctor';

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _handleSignup(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final requestBody = RegisterRequestBody(
        firstName: _firstNameCtrl.text.trim(),
        lastName: _lastNameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        password: _passwordCtrl.text.trim(),
        role: _selectedRole,
        platform: Platform.isAndroid ? 'android' : 'ios',
        deviceType: 'mobile',
      );
      context.read<RegisterCubit>().emitRegisterStates(requestBody);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterCubit>(),
      child: Scaffold(
        body: Stack(
          children: [
            // Background
            Positioned.fill(
              child: Image.asset(
                'assets/images/background/bg.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.35)),
            ),

            BlocListener<RegisterCubit, RegisterState>(
              listenWhen: (previous, current) =>
                  current is RegisterSuccess || current is RegisterError,
              listener: (context, state) {
                state.whenOrNull(
                  registerSuccess: (data) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        title: const Text('Registration Submitted'),
                        content: const Text(
                          'Your account is pending admin approval.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Get.back();
                            },
                            child: Text(
                              'Back to Login',
                              style: TextStyle(color: ColorApp.buttomColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  registerError: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        backgroundColor: Colors.red.shade600,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                );
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),

                        // Back button
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        Center(
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 26.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Fill in your details to get started',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        SizedBox(height: 28.h),

                        // First + Last name
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormFieldCore(
                                label: 'First Name',
                                hint: 'Amit',
                                icon: 'assets/images/Icons/Patient/Add/e.png',
                                widthIcon: 16.w,
                                heightIcon: 16.h,
                                controller: _firstNameCtrl,
                                fieldFillColor: Colors.white,
                                lableStyle: _labelStyle,
                                validator: (v) =>
                                    v == null || v.isEmpty ? 'Required' : null,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: CustomTextFormFieldCore(
                                label: 'Last Name',
                                hint: 'Sharma',
                                icon: 'assets/images/Icons/Patient/Add/e.png',
                                widthIcon: 16.w,
                                heightIcon: 16.h,
                                controller: _lastNameCtrl,
                                fieldFillColor: Colors.white,
                                lableStyle: _labelStyle,
                                validator: (v) =>
                                    v == null || v.isEmpty ? 'Required' : null,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14.h),

                        CustomTextFormFieldCore(
                          label: 'Email',
                          hint: 'doctor@clinic.com',
                          icon: 'assets/Icons/Patient/email.png',
                          widthIcon: 18.w,
                          heightIcon: 18.h,
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          fieldFillColor: Colors.white,
                          lableStyle: _labelStyle,
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Required';
                            if (!v.contains('@')) return 'Invalid email';
                            return null;
                          },
                        ),
                        SizedBox(height: 14.h),

                        CustomTextFormFieldCore(
                          label: 'Phone (optional)',
                          hint: '9876543210',
                          icon: 'assets/images/Icons/Patient/Add/p.png',
                          widthIcon: 16.w,
                          heightIcon: 16.h,
                          controller: _phoneCtrl,
                          keyboardType: TextInputType.phone,
                          fieldFillColor: Colors.white,
                          lableStyle: _labelStyle,
                        ),
                        SizedBox(height: 14.h),

                        // Password Field (Modular widget)
                        PasswordField(
                          controller: _passwordCtrl,
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Required';
                            if (v.length < 6) return 'Min 6 characters';
                            return null;
                          },
                        ),
                        SizedBox(height: 14.h),

                        // Role Selector (Modular widget)
                        Text('ROLE', style: _labelStyle),
                        SizedBox(height: 8.h),
                        RoleSelector(
                          selected: _selectedRole,
                          onChanged: (role) {
                            setState(() {
                              _selectedRole = role;
                            });
                          },
                        ),
                        SizedBox(height: 30.h),

                        // Submit Button
                        Builder(
                          builder: (context) {
                            return BlocBuilder<RegisterCubit, RegisterState>(
                              builder: (context, state) {
                                final isLoading = state is RegisterLoading;
                                return CustomButton(
                                  onPressed: isLoading
                                      ? null
                                      : () => _handleSignup(context),
                                  text: isLoading
                                      ? 'Creating Account...'
                                      : 'Create Account',
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 20.h),

                        Center(
                          child: GestureDetector(
                            onTap: () => Get.back(),
                            child: Text.rich(
                              TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13.sp,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Login',
                                    style: TextStyle(
                                      color: ColorApp.textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Loading overlay
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                if (state is RegisterLoading) {
                  return Container(
                    color: Colors.black38,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get _labelStyle => TextStyle(
    fontSize: 12.sp,
    color: Colors.white70,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8.w,
  );
}
