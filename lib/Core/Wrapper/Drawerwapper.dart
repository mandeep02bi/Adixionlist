import 'package:doctor/Core/Controller.dart/drawercontroller.dart';
import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Core/helper/token_storage_service.dart';
import 'package:doctor/Presentation/Onboarding/Onboardsc.dart';
import 'package:doctor/Presentation/Patient/Patientlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DrawerWrapper extends StatefulWidget {
  final Widget child;

  const DrawerWrapper({super.key, required this.child});

  @override
  State<DrawerWrapper> createState() => _DrawerWrapperState();
}

class _DrawerWrapperState extends State<DrawerWrapper> {
  final controller = Get.put(DrawerControllerX());
  
  String _doctorName = "Dr. Suraj Kumnar";
  String _doctorCode = "01303-527300";

  @override
  void initState() {
    super.initState();
    _loadDoctorInfo();
  }

  Future<void> _loadDoctorInfo() async {
    try {
      final storage = getIt<TokenStorageService>();
      final firstName = await storage.getUserFirstName();
      final lastName = await storage.getUserLastName();
      final code = await storage.getUserCode();
      if (mounted) {
        setState(() {
          if (firstName != null || lastName != null) {
            _doctorName = "Dr. ${firstName ?? ''} ${lastName ?? ''}".trim();
          }
          if (code != null && code.trim().isNotEmpty) {
            _doctorCode = code;
          }
        });
      }
    } catch (e) {
      debugPrint("Error loading doctor info in drawer: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(
          children: [
            /// 🔥 DRAWER
            _buildDrawer(),

            /// 🔥 MAIN SCREEN (ANIMATED)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: controller.isOpen.value ? 250.w : 0,
              right: controller.isOpen.value ? -150.w : 0,
              top: controller.isOpen.value ? 80.h : 0,
              bottom: controller.isOpen.value ? 80.h : 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    controller.isOpen.value ? 30.r : 0),
                child: controller.isOpen.value
                    ? GestureDetector(
                        onTap: controller.closeDrawer,
                        child: AbsorbPointer(
                          absorbing: true,
                          child: widget.child,
                        ),
                      )
                    : widget.child,
              ),
            ),
          ],
        );
      }),
    );
  }

  /// ================= DRAWER =================
  Widget _buildDrawer() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 50.h, left: 16.w, right: 16.w, bottom: 20.h),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF5F6D8A), Color(0xFF3B4A6B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.person, color: Colors.white, size: 28.sp),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _doctorName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Rubik",
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          _doctorCode,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13.sp,
                            fontFamily: "Rubik",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                GestureDetector(
                  onTap: controller.closeDrawer,
                  child: Container(
                    height: 32.h,
                    width: 32.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE53935),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Icon(Icons.close, color: Colors.white, size: 18.sp),
                  ),
                ),
              ],
            ),

            SizedBox(height: 35.h),

            /// MENU ITEMS
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  _menuItem(Icons.person, "Profile", true, () {
                    controller.closeDrawer();
                  }),
                  _menuItem(Icons.people_outline, "My Patients", false, () {
                    controller.closeDrawer();
                    Get.to(() => const PatientListScreen());
                  }),
                  _menuItem(Icons.payment, "Payments", false, () {
                    controller.closeDrawer();
                  }),
                  _menuItem(Icons.description, "E-Letter head", false, () {
                    controller.closeDrawer();
                  }),
                  _menuItem(Icons.feedback_outlined, "Feedback", false, () {
                    controller.closeDrawer();
                  }),
                  _menuItem(Icons.privacy_tip_outlined, "Privacy & Policy", false, () {
                    controller.closeDrawer();
                  }),
                  _menuItem(Icons.help_outline, "FAQ's", false, () {
                    controller.closeDrawer();
                  }),
                  _menuItem(Icons.settings_outlined, "Settings", false, () {
                    controller.closeDrawer();
                  }),
                  _menuItem(Icons.star_border, "Rate and review", false, () {
                    controller.closeDrawer();
                  }),
                  _menuItem(Icons.phone_in_talk_outlined, "Contact Us", false, () {
                    controller.closeDrawer();
                  }),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            _menuItem(Icons.logout, "Logout", false, () async {
              controller.closeDrawer();
              await getIt<TokenStorageService>().clearAll();
              Get.offAll(() => const Onboardsc());
            }),
          ],
        ),
      ),
    );
  }

  /// ================= MENU ITEM =================
  Widget _menuItem(IconData icon, String title, bool isActive, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: isActive
              ? Border.all(color: Colors.white.withOpacity(0.15), width: 1)
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  Icon(icon, color: isActive ? Colors.white : Colors.white70, size: 22.sp),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.white70,
                        fontSize: 15.sp,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                        fontFamily: "Rubik",
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: isActive ? Colors.white70 : Colors.white30,
                    size: 13.sp,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}