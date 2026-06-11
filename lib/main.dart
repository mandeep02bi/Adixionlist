import 'package:doctor/Core/Controller.dart/themecontroller.dart';
import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Presentation/HomeScreen/doctor_home_sc.dart';
import 'package:doctor/Presentation/Splash/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(
          () => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeController.theme,
            theme: ThemeData(
              brightness: Brightness.light,
              fontFamily: "Rubik",
              scaffoldBackgroundColor: Colors.white,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: "Rubik",
              scaffoldBackgroundColor: Colors.black,
            ),
            home:
                const AnimatedSplashScreen(), // Open home page directly without login
          ),
        );
      },
    );
  }
}
