import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Core/widgets/custom_text_form_field_core.dart';
import 'package:doctor/Presentation/AuthScreen/data/models/login_request_body.dart';
import 'package:doctor/Presentation/AuthScreen/logic/login/login_cubit.dart';
import 'package:doctor/Presentation/AuthScreen/logic/login/login_state.dart';
import 'package:doctor/Presentation/AuthScreen/widgets/forgot_password_link.dart';
import 'package:doctor/Presentation/AuthScreen/widgets/login_button.dart';
import 'package:doctor/Presentation/AuthScreen/widgets/login_header.dart';
import 'package:doctor/Presentation/AuthScreen/widgets/password_field.dart';
import 'package:doctor/Presentation/AuthScreen/widgets/signup_link.dart';
import 'package:doctor/Core/Wrapper/Drawerwapper.dart';
import 'package:doctor/Presentation/HomeScreen/doctor_home_sc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Loginsc extends StatefulWidget {
  const Loginsc({super.key});

  @override
  State<Loginsc> createState() => _LoginscState();
}

class _LoginscState extends State<Loginsc> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().emitLoginStates(
        LoginRequestBody(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
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

            BlocListener<LoginCubit, LoginState>(
              listenWhen: (previous, current) =>
                  current is LoginSuccess || current is LoginError,
              listener: (context, state) {
                state.whenOrNull(
                  loginSuccess: (loginResponse) {
                    Get.offAll(() => DrawerWrapper(child: const Doctorhomesc()));
                  },
                  loginError: (message) {
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const LoginHeader(),
                        SizedBox(height: 36.h),

                        // Email Field
                        CustomTextFormFieldCore(
                          label: 'Email',
                          hint: 'doctor@clinic.com',
                          icon: 'assets/Icons/Patient/email.png',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          fieldFillColor: Colors.white,
                          lableStyle: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8.w,
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Email is required';
                            }
                            if (!v.contains('@')) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),

                        // Password Field
                        PasswordField(
                          controller: _passwordController,
                          validator: (v) => v == null || v.isEmpty
                              ? 'Password is required'
                              : null,
                        ),
                        SizedBox(height: 10.h),

                        // Forgot Password Link
                        const ForgotPasswordLink(),
                        SizedBox(height: 30.h),

                        // Login Button
                        Builder(
                          builder: (context) {
                            return BlocBuilder<LoginCubit, LoginState>(
                              builder: (context, state) {
                                final isLoading = state is LoginLoading;
                                return LoginButton(
                                  isLoading: isLoading,
                                  onPressed: isLoading
                                      ? () {} // Do nothing when loading
                                      : () => _handleLogin(context),
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 24.h),

                        // Sign Up Link Prompt
                        const SignupLink(),
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Loading overlay
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
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
}
