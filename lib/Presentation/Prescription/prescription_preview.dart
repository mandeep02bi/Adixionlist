// import 'package:doctor/Presentation/Prescription/widgets/button_prescription.dart';
// import 'package:doctor/core/Theme/color_app.dart';
// import 'package:doctor/Core/helper/image_assets.dart';
// import 'package:doctor/Data/Data_source/Medicine_datasource.dart';
// import 'package:doctor/Data/model/medicine_model.dart';
// import 'package:doctor/widgets/Add_patient/custom_button.dart';
// import 'package:doctor/Presentation/Prescription/widgets/custom_hader_preview.dart';
// import 'package:doctor/Presentation/Prescription/widgets/custom_text_form_field.dart';
// import 'package:flutter/material.dart';

// class PrescriptionPreviewPage extends StatefulWidget {
//   const PrescriptionPreviewPage({super.key});

//   @override
//   State<PrescriptionPreviewPage> createState() =>
//       _PrescriptionPreviewPageState();
// }

// class _PrescriptionPreviewPageState extends State<PrescriptionPreviewPage> {
//   void _refreshData() => setState(() {});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorApp.scaffoldColor,
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(ImageAssets.backgroundImagePath2),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomHaderPreview(
//                 title: 'Prescription Preview',
//                 bottomCard: Container(
//                   padding: const EdgeInsets.all(14),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.08),
//                         blurRadius: 10,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Patient + Age Row
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               const CircleAvatar(
//                                 radius: 26,
//                                 backgroundImage: AssetImage(ImageAssets.avatar),
//                               ),
//                               const SizedBox(width: 12),
//                               const Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Patient',
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                   Text(
//                                     'Akash Tomar',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: Color(0xFF1A1A2E),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 'Age',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               Text(
//                                 '28 Years',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xFF1A1A2E),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),

//                       const Divider(height: 16, color: Color(0xFFEEEEEE)),

//                       // Diagnosis Row
//                       Row(
//                         children: [
//                           Image.asset(
//                             ImageAssets.stethoscope,
//                             width: 16,
//                             height: 16,
//                             color: Colors.purple,
//                           ),
//                           const SizedBox(width: 6),
//                           const Text(
//                             'Diagnosis: ',
//                             style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF1A1A2E),
//                             ),
//                           ),
//                           const Expanded(
//                             child: Text(
//                               'Viral Fever & Throat Infection',
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Color(0xFF64748B),
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 66),

//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 12,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 16),

//                       FutureBuilder<List<MedicineModel>>(
//                         future: MedicineDatabase.instance.getAllMedicines(),
//                         builder: (context, snapshot) {
//                           final medicines = snapshot.data ?? [];
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               _SectionHeader(
//                                 icon: ImageAssets.drugs,
//                                 title: 'Medicines',
//                                 count: medicines.length,
//                               ),
//                               const SizedBox(height: 10),
//                               ...medicines.map(
//                                 (med) => _MedicineCard(
//                                   med: med,
//                                   onDelete: () async {
//                                     await MedicineDatabase.instance
//                                         .deleteMedicine(med.id!);
//                                     _refreshData();
//                                   },
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),

//                       const SizedBox(height: 16),

//                       FutureBuilder<List<MedicineModel>>(
//                         future: MedicineDatabase.instance.getAllLabTests(),
//                         builder: (context, snapshot) {
//                           final labTests = snapshot.data ?? [];
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               _SectionHeader(
//                                 icon: ImageAssets.lab,
//                                 title: 'Lab Test',
//                                 count: labTests.length,
//                               ),
//                               const SizedBox(height: 10),
//                               ...labTests.map(
//                                 (lab) => _LabTestCard(
//                                   lab: lab,
//                                   onDelete: () async {
//                                     await MedicineDatabase.instance
//                                         .deleteMedicine(lab.id!);
//                                     _refreshData();
//                                   },
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),

//                       const SizedBox(height: 16),

//                       const CustomTextFormField(
//                         label: 'Notes',
//                         lableStyle: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xFF2C2C2C),
//                         ),
//                         fieldFillColor: Color(0xFFFBFEFF),
//                         hintStyle: TextStyle(
//                           fontSize: 12,
//                           color: Color(0xFF5B5B5B),
//                         ),
//                         hint:
//                             'Take complete rest for 2-3 days. Drink of fluids. Follow up after 5 days if symptoms persist.',
//                         keyboardType: TextInputType.multiline,
//                       ),

//                       const SizedBox(height: 24),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: CustomButton(
//                               onPressed: () {},
//                               height: 46,
//                               width: 165,
//                               text: 'Add Medicine',
//                               text2: 'Send',
//                               height2: 46,
//                               width2: 130,
//                               image: ImageAssets.add,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 15),

//                       Row(
//                         children: [
//                           CustomButton(
//                             height: 45.83,
//                             width: 145,
//                             text: 'Preview Prescription',
//                             textStyle: TextStyle(
//                               fontSize: 12,
//                               color: ColorApp.textColor,
//                             ),
//                             // assetIcon: ImageAssets.drft,
//                             buttonColor: Color(0xFFFFFFFF),
//                             border: Border.all(color: ColorApp.textColor),
//                             onPressed: () {},
//                           ),
//                           const SizedBox(width: 10),
//                           CustomButton(
//                             height: 55,
//                             width: 170,
//                             onPressed: () {},
//                             text: 'Download Prescription',

//                             buttonColor: Color(0xFF8D34B0),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Section Header
// class _SectionHeader extends StatelessWidget {
//   final String icon;
//   final String title;
//   final int count;

//   const _SectionHeader({
//     required this.icon,
//     required this.title,
//     required this.count,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             Image.asset(icon, width: 26, height: 26),
//             const SizedBox(width: 8),
//             Text(
//               title,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//           decoration: BoxDecoration(
//             color: const Color(0xFFE8F5E9),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Text(
//             '$count Items',
//             style: const TextStyle(
//               color: Colors.green,
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // Medicine Card
// class _MedicineCard extends StatelessWidget {
//   final MedicineModel med;
//   final VoidCallback onDelete;

//   const _MedicineCard({required this.med, required this.onDelete});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.asset(ImageAssets.baneg, width: 30, height: 30),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         med.medicineName,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF333333),
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: onDelete,
//                       child: const Icon(
//                         Icons.delete_outline,
//                         color: Color(0xFFE57373),
//                         size: 22,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           const TextSpan(
//                             text: 'Dosage: ',
//                             style: TextStyle(
//                               color: Colors.purple,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 13,
//                             ),
//                           ),
//                           TextSpan(
//                             text: '${med.qty} tablet',
//                             style: const TextStyle(
//                               color: Color(0xFF64748B),
//                               fontSize: 13,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     const Icon(
//                       Icons.access_time,
//                       size: 14,
//                       color: Color(0xFF4DB6AC),
//                     ),
//                     const SizedBox(width: 4),
//                     Expanded(
//                       child: Text(
//                         med.frequency,
//                         style: const TextStyle(
//                           color: Color(0xFF64748B),
//                           fontSize: 13,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.calendar_today_outlined,
//                       size: 14,
//                       color: Color(0xFF4DB6AC),
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       '${med.noOfDays} days',
//                       style: const TextStyle(
//                         color: Color(0xFF64748B),
//                         fontSize: 13,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Text(
//                         med.instruction,
//                         style: const TextStyle(
//                           color: Color(0xFF64748B),
//                           fontSize: 13,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _LabTestCard extends StatelessWidget {
//   final MedicineModel lab;
//   final VoidCallback onDelete;

//   const _LabTestCard({required this.lab, required this.onDelete});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: const Color(0xFFFFF3E0),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Image.asset(ImageAssets.lab, width: 28, height: 28),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         lab.medicineName,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF333333),
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: onDelete,
//                       child: const Icon(
//                         Icons.delete_outline,
//                         color: Color(0xFFE57373),
//                         size: 22,
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (lab.instruction.isNotEmpty) ...[
//                   const SizedBox(height: 6),
//                   RichText(
//                     text: TextSpan(
//                       children: [
//                         const TextSpan(
//                           text: 'How ',
//                           style: TextStyle(
//                             color: Colors.purple,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 13,
//                           ),
//                         ),
//                         TextSpan(
//                           text: lab.instruction,
//                           style: const TextStyle(
//                             color: Color(0xFF64748B),
//                             fontSize: 13,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
