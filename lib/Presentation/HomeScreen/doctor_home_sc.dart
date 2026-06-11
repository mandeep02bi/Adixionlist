
import 'package:doctor/Core/Bloc/Home_bloc.dart';
import 'package:doctor/Core/Controller.dart/themecontroller.dart';
import 'package:doctor/Presentation/HomeScreen/widgets/bttom_navigation_bar.dart';
import 'package:doctor/Presentation/HomeScreen/widgets/content.dart';
import 'package:doctor/Presentation/HomeScreen/widgets/custom_header_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';

class Doctorhomesc extends StatefulWidget {
  const Doctorhomesc({super.key});

  @override
  State<Doctorhomesc> createState() => _DoctorhomescState();
}

class _DoctorhomescState extends State<Doctorhomesc> {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(LoadHome()),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Stack(
                children: [
                  /// Background Image
                  Positioned.fill(
                    child: Image.asset(
                      "assets/images/background/05_Home screen.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// Main Content
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: state.isLoading ? 0 : 1,
                    child: Column(
                      children: [
                        const CustomHeaderHome(),
                        Expanded(child: Content()),
                        // SizedBox(height: 80),
                      ],
                    ),
                  ),

                  /// Loading
                  if (state.isLoading)
                    Center(child: CircularProgressIndicator()),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          selectedIndex: 0,
          onTap: (int value) {},
        ),
      ),
    );
  }
}
