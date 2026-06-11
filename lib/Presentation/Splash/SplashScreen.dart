import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Core/helper/token_storage_service.dart';
import 'package:doctor/Presentation/Onboarding/Onboardsc.dart';
import 'package:doctor/Presentation/HomeScreen/doctor_home_sc.dart';
import 'package:doctor/Core/Wrapper/Drawerwapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:async';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 0.6, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    /// Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () async {
      final token = await getIt<TokenStorageService>().getAccessToken();
      if (token != null && token.isNotEmpty) {
        Get.offAll(() => DrawerWrapper(child: const Doctorhomesc()));
      } else {
        Get.to(() => const Onboardsc()); // change route
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/images/background/05_Home screen.jpg",
              fit: BoxFit.cover,
            ),
          ),

          /// Gradient overlay (optional)
          Container(
            color: Colors.black.withOpacity(0.2),
          ),

          /// Animated Logo
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset(
                    "assets/images/logo/logo.png",
                    width: 220.w,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}