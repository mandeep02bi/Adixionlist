import 'package:doctor/Presentation/MyTemplate/cubit/template_cubit.dart';
import 'package:doctor/Presentation/MyTemplate/cubit/template_state.dart';
import 'package:doctor/Presentation/MyTemplate/widgets/patine_widgets_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabTemplate extends StatelessWidget {
  final String templateType;

  const LabTemplate({super.key, required this.templateType});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateCubit, TemplateState>(
      builder: (context, state) {
        if (state is TemplateLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TemplateLoaded) {
          if (state.templates.isEmpty) {
            return const Center(child: Text("No Lab Test Templates Found"));
          }
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            itemCount: state.templates.length,
            itemBuilder: (context, index) {
              final template = state.templates[index];

              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: PatineWidgetsTemplate(
                  name: template.title,
                  onView: () {
                    print("LAB TEMPLATE CLICKED");
                    print(template.content);

                    Navigator.pop(context, template.content);
                  },
                ),
              );
            },
          );
        }

        if (state is TemplateError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }
}
