// import 'package:doctor/Presentation/Consent/cubit/consent_cubit.dart';
// import 'package:doctor/Presentation/Consent/cubit/consent_state.dart';
// import 'package:doctor/Presentation/MyTemplate/widgets/patine_widgets_template.dart';
// import 'package:doctor/Presentation/Prescription/widgets/custom_text_form_field.dart';
// import 'package:doctor/core/Theme/color_app.dart';
// import 'package:doctor/Core/helper/image_assets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ConsentTemplate extends StatefulWidget {
//   final String templateType;
//   final String patientCode;

//   const ConsentTemplate({
//     super.key,
//     required this.templateType,
//     required this.patientCode,
//   });

//   @override
//   State<ConsentTemplate> createState() => _ConsentTemplateState();
// }

// class _ConsentTemplateState extends State<ConsentTemplate> {
//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       context.read<ConsentCubit>().getConsents(widget.patientCode);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ConsentCubit, ConsentState>(
//       listener: (context, state) {
//         if (state is ConsentDetailsLoaded) {
//           showDialog(
//             context: context,
//             builder: (_) {
//               return AlertDialog(
//                 title: Text(state.consent.title),
//                 content: SingleChildScrollView(
//                   child: Text(state.consent.description),
//                 ),
//                 actions: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: const Text("Close"),
//                   ),
//                 ],
//               );
//             },
//           );
//         }

//         if (state is ConsentDeleted) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text(state.message)));
//         }

//         if (state is ConsentError) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text(state.message)));
//         }
//       },
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 8.w),
//         child: Column(
//           children: [
//             CustomTextFormField(
//               label: '',
//               hint: 'Consent',
//               fieldFillColor: ColorApp.scaffoldColor,
//               icon: ImageAssets.consent,
//               heightIcon: 18.h,
//               widthIcon: 18.w,
//               hintStyle: TextStyle(
//                 fontSize: 11.sp,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),

//             SizedBox(height: 10.h),

//             // Expanded(
//             //   child: BlocBuilder<ConsentCubit, ConsentState>(
//             //     builder: (context, state) {
//             //       if (state is ConsentLoading) {
//             //         return const Center(child: CircularProgressIndicator());
//             //       }

//             //       if (state is ConsentLoaded) {
//             //         if (state.consents.isEmpty) {
//             //           return const Center(child: Text("No Consent Found"));
//             //         }

//             //         return ListView.builder(
//             //           itemCount: state.consents.length,
//             //           itemBuilder: (context, index) {
//             //             final consent = state.consents[index];

//             //             return Padding(
//             //               padding: EdgeInsets.only(bottom: 10.h),
//             //               child: PatineWidgetsTemplate(
//             //                 name: consent.title,

//             //                 onDelete: () {
//             //                   context.read<ConsentCubit>().deleteConsent(
//             //                     consent.id,
//             //                     widget.patientCode,
//             //                   );
//             //                 },

//             //                 onView: () {
//             //                   context.read<ConsentCubit>().getConsentDetails(
//             //                     consent.id,
//             //                   );
//             //                 },

//             //                 onEdit: () {
//             //                   ScaffoldMessenger.of(context).showSnackBar(
//             //                     const SnackBar(
//             //                       content: Text("Edit Consent Coming Soon"),
//             //                     ),
//             //                   );
//             //                 },
//             //               ),
//             //             );
//             //           },
//             //         );
//             //       }

//             //       if (state is ConsentError) {
//             //         return Center(child: Text(state.message));
//             //       }

//             //       return const SizedBox();
//             //     },
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
