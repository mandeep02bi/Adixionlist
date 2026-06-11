import 'package:doctor/core/Theme/color_app.dart';
import 'package:doctor/Core/helper/image_assets.dart';
import 'package:doctor/Data/Data_source/Medicine_datasource.dart';
import 'package:doctor/Data/model/medicine_model.dart';
import 'package:doctor/widgets/Add_patient/custom_button.dart';
import 'package:doctor/widgets/Add_patient/custom_text_field.dart';
import 'package:flutter/material.dart';

Future<void> showAddMedicineSheet(
  BuildContext context, {
  String? title,
  String? nameOf,
  String? lableqty,
  String? name,
  String? qty,
  String? lableFrequency,
  String? frequency,
  String? lableRoute,
  String? route,
  String? lableNoofDay,
  String? noofDay,
  String? lableinstruction,
  String? instruction,
  String? textButtom,
  String? iconButtom,
  Widget? customButtom,
  bool showMedicineFields = true,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => AddMedicineSheet(
      title: title,
      nameOf: nameOf,
      lableqty: lableqty,
      name: name,
      qty: qty,
      lableFrequency: lableFrequency,
      frequency: frequency,
      customButtom: customButtom,
      lableRoute: lableRoute,
      route: route,
      lableNoofDay: lableNoofDay,
      noofDay: noofDay,
      lableinstruction: lableinstruction,
      instruction: instruction,
      textButtom: textButtom,
      iconButtom: iconButtom,
      showMedicineFields: showMedicineFields,
    ),
  );
}

class AddMedicineSheet extends StatefulWidget {
  final String? title;
  final String? nameOf;
  final String? lableqty;
  final String? name;
  final String? qty;
  final String? lableFrequency;
  final String? frequency;
  final String? lableRoute;
  final String? route;
  final String? lableNoofDay;
  final String? noofDay;
  final String? lableinstruction;
  final String? instruction;
  final String? textButtom;
  final String? iconButtom;
  final bool showMedicineFields;
  final Widget? customButtom;

  const AddMedicineSheet({
    super.key,
    this.title,
    this.nameOf,
    this.lableqty,
    this.name,
    this.qty,
    this.lableFrequency,
    this.frequency,
    this.lableRoute,
    this.route,
    this.lableNoofDay,
    this.customButtom,
    this.noofDay,
    this.lableinstruction,
    this.instruction,
    this.textButtom,
    this.iconButtom,
    this.showMedicineFields = true,
  });

  @override
  State<AddMedicineSheet> createState() => _AddMedicineSheetState();
}

class _AddMedicineSheetState extends State<AddMedicineSheet> {
  late final TextEditingController medicineNameController;
  late final TextEditingController qtyController;
  late final TextEditingController frequencyController;
  late final TextEditingController routeFormController;
  late final TextEditingController noOfDaysController;
  late final TextEditingController instructionController;

  @override
  void initState() {
    super.initState();
    medicineNameController = TextEditingController();
    qtyController = TextEditingController();
    frequencyController = TextEditingController();
    routeFormController = TextEditingController();
    noOfDaysController = TextEditingController();
    instructionController = TextEditingController();
  }

  @override
  void dispose() {
    medicineNameController.dispose();
    qtyController.dispose();
    frequencyController.dispose();
    routeFormController.dispose();
    noOfDaysController.dispose();
    instructionController.dispose();
    super.dispose();
  }

  Future<void> _onAddMedicine() async {
    if (medicineNameController.text.trim().isEmpty) return;
    final medicine = MedicineModel(
      medicineName: medicineNameController.text.trim(),
      qty: qtyController.text.trim(),
      frequency: frequencyController.text.trim(),
      routeForm: routeFormController.text.trim(),
      noOfDays: noOfDaysController.text.trim(),
      instruction: instructionController.text.trim(),
      type: widget.showMedicineFields ? 'medicine' : 'lab',
    );
    await MedicineDatabase.instance.insertMedicine(medicine);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.50,
      minChildSize: 0.4,
      maxChildSize: 0.90,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container( 
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            child: ListView(
              controller: scrollController,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                // Drag Handle
                Center(
                  child: Container(
                    height: 5,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Title + Close Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title ?? "Add Medicine",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        ImageAssets.remove,
                        height: 35,
                        width: 35,
                      ),
                    ),
                  ],
                ),

                // const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.nameOf ?? "Name of Medicine / Product",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: ColorApp.labelColor,
                        fontSize: 14,
                      ),
                    ),
                    if (widget.showMedicineFields)
                      Text(
                        widget.lableqty ?? "T.Qty",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: ColorApp.labelColor,
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      flex: widget.showMedicineFields ? 2 : 1,
                      child: CustomFormField(
                        controller: medicineNameController,
                        label: '',
                        hint: widget.name ?? 'Medicine Name',
                        icon: ImageAssets.stethoscope,
                        fieldFillColor: const Color(0xFFF9FCFF),
                        widthIcon: 18,
                        heightIcon: 18,
                      ),
                    ),
                    if (widget.showMedicineFields) ...[
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomFormField(
                          controller: qtyController,
                          label: '',
                          hint: widget.qty ?? 'Qty',
                          fieldFillColor: const Color(0xFFF9FCFF),
                        ),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child:
                          widget.customButtom ??
                          CustomButton(
                            height: 60,
                            width: 150,
                            onPressed: () {},
                            text: 'Save and Add',
                            textStyle: TextStyle(
                              fontSize: 12,
                              color: ColorApp.textColor,
                            ),
                            border: Border.all(
                              color: ColorApp.textColor,
                              width: 1,
                            ),
                            buttonColor: ColorApp.scaffoldColor,
                            assetIcon: ImageAssets.drft,
                          ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child:
                          widget.customButtom ??
                          CustomButton(
                            height: 60,
                            width: 150,

                            onPressed: () {},
                            text: 'Choose Template',
                            assetIcon: ImageAssets.drft,
                            textStyle: TextStyle(
                              fontSize: 12,
                              color: ColorApp.textColor,
                            ),
                            border: Border.all(
                              color: ColorApp.textColor,
                              width: 1,
                            ),
                            buttonColor: ColorApp.scaffoldColor,
                          ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                if (widget.showMedicineFields) ...[
                  Row(
                    children: [
                      Expanded(
                        child: CustomFormField(
                          controller: frequencyController,
                          label: widget.lableFrequency ?? 'Frequency',
                          hint: widget.frequency ?? '170',
                          icon: ImageAssets.heightPrescription,
                          widthIcon: 16,
                          heightIcon: 16,
                          fieldFillColor: ColorApp.scaffoldColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomFormField(
                          controller: routeFormController,
                          label: widget.lableRoute ?? 'Route/ form',
                          hint: widget.route ?? '65',
                          icon: ImageAssets.weight,
                          widthIcon: 16,
                          heightIcon: 16,
                          fieldFillColor: ColorApp.scaffoldColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // No of Days + Instruction
                  Row(
                    children: [
                      Expanded(
                        child: CustomFormField(
                          controller: noOfDaysController,
                          label: widget.lableNoofDay ?? 'No of Days',
                          hint: widget.noofDay ?? '170',
                          icon: ImageAssets.heightPrescription,
                          widthIcon: 16,
                          heightIcon: 16,
                          fieldFillColor: ColorApp.scaffoldColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomFormField(
                          controller: instructionController,
                          label: widget.lableinstruction ?? 'Instruction',
                          hint: widget.instruction ?? '65',
                          icon: ImageAssets.weight,
                          widthIcon: 16,
                          heightIcon: 16,
                          fieldFillColor: ColorApp.scaffoldColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],

                CustomFormField(
                  label: 'Additional Comments',
                  hint: "Add instructions, follow-up advice, restictions...",
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: ColorApp.labelColor,
                  ),
                  keyboardType: TextInputType.multiline,
                  fieldFillColor: Color(0xFFF9FCFF),
                ),

                const SizedBox(height: 20),

                Center(
                  child: CustomButton(
                    onPressed: _onAddMedicine,
                    text: widget.textButtom ?? 'Add Medicine',
                    height: 60,
                    width: 250,
                    assetIcon: widget.iconButtom ?? ImageAssets.drugs,
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
