import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Core/helper/image_assets.dart';
import 'package:doctor/Presentation/Consent/cubit/consent_cubit.dart';
import 'package:doctor/Presentation/MyTemplate/cubit/template_cubit.dart';
import 'package:doctor/Presentation/MyTemplate/widgets/custom_header_template.dart';
import 'package:doctor/core/Theme/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTemplate extends StatelessWidget {
  final String type;
  final String? patientCode;

  const MyTemplate({super.key, required this.type, this.patientCode});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<TemplateCubit>()..getTemplates(type)),
        //  BlocProvider(create: (_) => getIt<ConsentCubit>()),
      ],
      child: Scaffold(
        backgroundColor: ColorApp.scaffoldColor,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.backgroundImagePath2),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: SizedBox.expand(
              child: CustomHeaderTemplate(
                title: '$type Template',
                templateType: type,
                patientCode: patientCode,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
