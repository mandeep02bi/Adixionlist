import 'package:doctor/Core/Theme/color_app.dart';
import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Core/widgets/custom_button.dart';
import 'package:doctor/Core/widgets/custom_text_form_field_core.dart';
import 'package:doctor/Presentation/AuthScreen/logic/forgot_password/forgot_password_cubit.dart';
import 'package:doctor/Presentation/AuthScreen/logic/forgot_password/forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum ForgotPasswordStep { email, otp, newPassword }

class ForgotPasswordSC extends StatefulWidget {
  const ForgotPasswordSC({super.key});

  @override
  State<ForgotPasswordSC> createState() => _ForgotPasswordSCState();
}

class _ForgotPasswordSCState extends State<ForgotPasswordSC> {
  final _emailCtrl = TextEditingController();
  final _otpCtrl = TextEditingController();
  final _newPasswordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ForgotPasswordStep _currentStep = ForgotPasswordStep.email;
  bool _obscureText = true;
  String _email = '';

  @override
  void dispose() {
    _emailCtrl.dispose();
    _otpCtrl.dispose();
    _newPasswordCtrl.dispose();
    super.dispose();
  }

  void _handleSendOtp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _email = _emailCtrl.text.trim();
      context.read<ForgotPasswordCubit>().emitSendOtpStates(_email);
    }
  }

  void _handleVerifyOtp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ForgotPasswordCubit>().emitVerifyOtpStates(_email, _otpCtrl.text.trim());
    }
  }

  void _handleResetPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ForgotPasswordCubit>().emitResetPasswordStates(_email, _newPasswordCtrl.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ForgotPasswordCubit>(),
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

            BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
              listener: (context, state) {
                state.whenOrNull(
                  sendOtpSuccess: (data) {
                    setState(() {
                      _currentStep = ForgotPasswordStep.otp;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('OTP sent to your email successfully'),
                        backgroundColor: Colors.green.shade600,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  sendOtpError: (message) {
                    _showErrorSnackBar(context, message);
                  },
                  verifyOtpSuccess: (data) {
                    setState(() {
                      _currentStep = ForgotPasswordStep.newPassword;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('OTP verified successfully'),
                        backgroundColor: Colors.green.shade600,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  verifyOtpError: (message) {
                    _showErrorSnackBar(context, message);
                  },
                  resetPasswordSuccess: (data) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Password reset successful'),
                        backgroundColor: Colors.green.shade600,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (mounted) Get.back();
                    });
                  },
                  resetPasswordError: (message) {
                    _showErrorSnackBar(context, message);
                  },
                );
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                      SizedBox(height: 30.h),

                      // Step indicator
                      _StepIndicator(step: _currentStep),
                      SizedBox(height: 28.h),

                      // Step content
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _buildStepContent(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Loading overlay
            BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
              builder: (context, state) {
                final isLoading = state is SendOtpLoading || 
                                  state is VerifyOtpLoading || 
                                  state is ResetPasswordLoading;
                if (isLoading) {
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

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      // ── Step 1: Email ────────────────────────────────────────────────────
      case ForgotPasswordStep.email:
        return Form(
          key: _formKey,
          child: Column(
            key: const ValueKey('step_email'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title('Forgot Password?'),
              _subtitle("Enter your registered email and we'll send you an OTP."),
              SizedBox(height: 28.h),
              CustomTextFormFieldCore(
                label: 'Email Address',
                hint: 'doctor@clinic.com',
                icon: 'assets/Icons/Patient/email.png',
                widthIcon: 18.w,
                heightIcon: 18.h,
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                fieldFillColor: Colors.white,
                lableStyle: _labelStyle,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Email is required';
                  if (!v.contains('@')) return 'Enter a valid email';
                  return null;
                },
              ),
              SizedBox(height: 30.h),
              Builder(
                builder: (context) {
                  return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                    builder: (context, state) {
                      return CustomButton(
                        onPressed: state is SendOtpLoading ? () {} : () => _handleSendOtp(context),
                        text: state is SendOtpLoading ? 'Sending...' : 'Send OTP',
                      );
                    },
                  );
                }
              ),
            ],
          ),
        );

      // ── Step 2: OTP ──────────────────────────────────────────────────────
      case ForgotPasswordStep.otp:
        return Form(
          key: _formKey,
          child: Column(
            key: const ValueKey('step_otp'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title('Enter OTP'),
              _subtitle('We sent a one-time code to $_email'),
              SizedBox(height: 28.h),
              CustomTextFormFieldCore(
                label: 'OTP Code',
                hint: '------',
                controller: _otpCtrl,
                keyboardType: TextInputType.number,
                fieldFillColor: Colors.white,
                lableStyle: _labelStyle,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'OTP is required';
                  if (v.length < 4) return 'Enter the complete OTP';
                  return null;
                },
              ),
              SizedBox(height: 8.h),
              Align(
                alignment: Alignment.centerRight,
                child: Builder(
                  builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        context.read<ForgotPasswordCubit>().emitSendOtpStates(_email);
                      },
                      child: Text(
                        'Resend OTP',
                        style: TextStyle(
                          color: ColorApp.textColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }
                ),
              ),
              SizedBox(height: 24.h),
              Builder(
                builder: (context) {
                  return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                    builder: (context, state) {
                      return CustomButton(
                        onPressed: state is VerifyOtpLoading ? () {} : () => _handleVerifyOtp(context),
                        text: state is VerifyOtpLoading ? 'Verifying...' : 'Verify OTP',
                      );
                    },
                  );
                }
              ),
            ],
          ),
        );

      // ── Step 3: New Password ─────────────────────────────────────────────
      case ForgotPasswordStep.newPassword:
        return Form(
          key: _formKey,
          child: Column(
            key: const ValueKey('step_new_password'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title('New Password'),
              _subtitle('Choose a strong new password for your account.'),
              SizedBox(height: 28.h),
              _PasswordField(
                controller: _newPasswordCtrl,
                obscureText: _obscureText,
                onToggle: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Password is required';
                  if (v.length < 6) return 'Min 6 characters';
                  return null;
                },
              ),
              SizedBox(height: 30.h),
              Builder(
                builder: (context) {
                  return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                    builder: (context, state) {
                      return CustomButton(
                        onPressed: state is ResetPasswordLoading ? () {} : () => _handleResetPassword(context),
                        text: state is ResetPasswordLoading ? 'Resetting...' : 'Reset Password',
                      );
                    },
                  );
                }
              ),
            ],
          ),
        );
    }
  }

  Widget _title(String text) => Text(
        text,
        style: TextStyle(
          fontFamily: 'Rubik',
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );

  Widget _subtitle(String text) => Padding(
        padding: EdgeInsets.only(top: 6.h),
        child: Text(
          text,
          style: TextStyle(fontSize: 13.sp, color: Colors.white70, height: 1.4),
        ),
      );

  TextStyle get _labelStyle => TextStyle(
        fontSize: 12.sp,
        color: Colors.white70,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8.w,
      );
}

// ── Step Indicator ─────────────────────────────────────────────────────────

class _StepIndicator extends StatelessWidget {
  final ForgotPasswordStep step;
  const _StepIndicator({required this.step});

  @override
  Widget build(BuildContext context) {
    final steps = [
      ForgotPasswordStep.email,
      ForgotPasswordStep.otp,
      ForgotPasswordStep.newPassword,
    ];
    final currentIndex = steps.indexOf(step);

    return Row(
      children: List.generate(steps.length * 2 - 1, (i) {
        if (i.isOdd) {
          final lineIndex = i ~/ 2;
          final active = currentIndex > lineIndex;
          return Expanded(
            child: Container(
              height: 2.h,
              color: active ? ColorApp.buttomColor : Colors.white30,
            ),
          );
        }
        final dotIndex = i ~/ 2;
        final active = currentIndex >= dotIndex;
        return Container(
          width: 28.w,
          height: 28.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? ColorApp.buttomColor : Colors.white30,
          ),
          child: Center(
            child: Text(
              '${dotIndex + 1}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    );
  }
}

// ── Password Field (shared style matching CustomTextFormFieldCore) ──────────

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggle;
  final String? Function(String?)? validator;

  const _PasswordField({
    required this.controller,
    required this.obscureText,
    required this.onToggle,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NEW PASSWORD',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white70,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8.w,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          cursorColor: ColorApp.textColor,
          style: TextStyle(fontSize: 14.sp),
          decoration: InputDecoration(
            hintText: '••••••••',
            hintStyle: TextStyle(fontSize: 14.sp, color: ColorApp.hintColor),
            suffixIcon: GestureDetector(
              onTap: onToggle,
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Image.asset(
                  'assets/Icons/Eye.png',
                  width: 18.w,
                  height: 18.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF0F6E56), width: 1.2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          ),
        ),
      ],
    );
  }
}
