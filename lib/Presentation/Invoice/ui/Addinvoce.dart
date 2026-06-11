import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Core/helper/image_assets.dart';
import 'package:doctor/Presentation/Invoice/data/models/invoice_request_body.dart';
import 'package:doctor/Presentation/Invoice/data/models/invoice_item_request_body.dart';
import 'package:doctor/Presentation/Invoice/logic/invoice_cubit.dart';
import 'package:doctor/Presentation/Invoice/logic/invoice_state.dart';
import 'package:doctor/Presentation/Invoice/ui/more_details.dart';
import 'package:doctor/Presentation/Invoice/ui/widgets/custom_header_invoice.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
import 'package:doctor/Presentation/Patient/data/models/patients_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Addinvoce extends StatefulWidget {
  final PatientModel? patient;
  const Addinvoce({super.key, this.patient});

  @override
  State<Addinvoce> createState() => _AddinvoceState();
}

class _AddinvoceState extends State<Addinvoce>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  // Form Controllers
  final billToNameCtrl = TextEditingController();
  final invoiceTitleCtrl = TextEditingController();
  final discountTitleCtrl = TextEditingController();
  final advanceTitleCtrl = TextEditingController();
  final taxTitleCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  final remarkCtrl = TextEditingController();

  // Temporary Single Item Input Controllers
  final itemDescCtrl = TextEditingController();
  final itemAmountCtrl = TextEditingController();

  // Selections
  String? selectedPatientCode;
  String? selectedDiscountAmount = '0';
  String? selectedAdvanceAmount = '0';
  String? selectedTaxAmount = '0';
  String selectedStatus = 'To pay';

  // Loaded patients list
  List<PatientModel> patients = [];

  // Items list added locally
  List<InvoiceItemRequestBody> addedItems = [];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    
    // Set default date as today (YYYY-MM-DD)
    final now = DateTime.now();
    dateCtrl.text = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    
    // Preset titles
    invoiceTitleCtrl.text = "Invoice";
    discountTitleCtrl.text = "Discount";
    advanceTitleCtrl.text = "Amount Paid";
    taxTitleCtrl.text = "GST";
    remarkCtrl.text = "Consultation Fee";

    if (widget.patient != null) {
      selectedPatientCode = widget.patient!.patientCode;
      billToNameCtrl.text = widget.patient!.fullName;
    }

    super.initState();
  }

  // Calculate items total
  int get itemsTotal => addedItems.fold(0, (sum, item) => sum + item.amount.round());

  // Real-time calculation following backend specs: items_total + tax - discount - advance
  int get totalAmount {
    final double discount = double.tryParse(selectedDiscountAmount ?? '0') ?? 0;
    final double advance = double.tryParse(selectedAdvanceAmount ?? '0') ?? 0;
    final double taxPercent = double.tryParse(selectedTaxAmount ?? '0') ?? 0;

    double tempTotal = itemsTotal.toDouble();
    
    // Add tax percentage
    if (taxPercent > 0) {
      tempTotal += (itemsTotal * taxPercent) / 100;
    }
    
    // Subtract discount & advance
    tempTotal -= discount;
    tempTotal -= advance;

    return tempTotal.round().clamp(0, 999999999);
  }

  void addLocalItem() {
    final desc = itemDescCtrl.text.trim();
    final amount = double.tryParse(itemAmountCtrl.text) ?? 0.0;

    if (desc.isEmpty) {
      Get.snackbar(
        "Invalid Input",
        "Please enter an item description.",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (amount <= 0) {
      Get.snackbar(
        "Invalid Input",
        "Please enter a valid amount.",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    setState(() {
      addedItems.add(InvoiceItemRequestBody(description: desc, amount: amount));
      itemDescCtrl.clear();
      itemAmountCtrl.clear();
    });
  }

  void saveInvoice(BuildContext context) {
    if (selectedPatientCode == null) {
      Get.snackbar(
        "Validation Error",
        "Please select a patient first.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    if (billToNameCtrl.text.trim().isEmpty) {
      Get.snackbar(
        "Validation Error",
        "Please enter the billing name.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    if (invoiceTitleCtrl.text.trim().isEmpty) {
      Get.snackbar(
        "Validation Error",
        "Please enter the invoice title.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    if (addedItems.isEmpty) {
      Get.snackbar(
        "Validation Error",
        "Please add at least one item to the invoice.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    final body = InvoiceRequestBody(
      patientCode: selectedPatientCode!,
      billToName: billToNameCtrl.text.trim(),
      invoiceTitle: invoiceTitleCtrl.text.trim(),
      currency: "INR",
      discountTitle: discountTitleCtrl.text.trim(),
      discountValue: double.tryParse(selectedDiscountAmount ?? '0'),
      discountType: "Amount",
      advanceTitle: advanceTitleCtrl.text.trim(),
      advanceAmount: double.tryParse(selectedAdvanceAmount ?? '0'),
      taxTitle: taxTitleCtrl.text.trim(),
      taxValue: double.tryParse(selectedTaxAmount ?? '0'),
      taxType: "Percentage",
      remark: remarkCtrl.text.trim(),
      invoiceDate: dateCtrl.text.trim(),
      status: selectedStatus,
    );

    context.read<InvoiceCubit>().createInvoice(body, addedItems);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InvoiceCubit>(
      create: (context) => getIt<InvoiceCubit>()..getPatients(),
      child: Scaffold(
        backgroundColor: const Color(0xFFE9F1F6),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageAssets.backgroundImagePath2),
                fit: BoxFit.cover,
              ),
            ),
            child: Builder(
              builder: (context) {
                return BlocListener<InvoiceCubit, InvoiceState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      fetchPatientsSuccess: (data) {
                        setState(() {
                          patients = (data as PatientsListResponse).data ?? [];
                          if (widget.patient != null) {
                            selectedPatientCode = widget.patient!.patientCode;
                            billToNameCtrl.text = widget.patient!.fullName;
                          }
                        });
                      },
                      fetchPatientsError: (errorMsg) {
                        Get.snackbar(
                          "Error fetching patients",
                          errorMsg,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      },
                      createInvoiceSuccess: (data) {
                        Get.snackbar(
                          "Success",
                          "Invoice created successfully!",
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                        Navigator.pop(context, true);
                      },
                      createInvoiceError: (errorMsg) {
                        Get.snackbar(
                          "Error creating invoice",
                          errorMsg,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      },
                      orElse: () {},
                    );
                  },
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const CustomHeaderInvoice(title: 'Create Invoice'),

                          /// TABS
                          TabBar(
                            controller: tabController,
                            labelColor: Colors.black,
                            labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                            unselectedLabelStyle: TextStyle(fontSize: 14.sp),
                            tabs: const [
                              Tab(text: "Invoice details"),
                              Tab(text: "More details"),
                            ],
                          ),

                          Expanded(
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                /// 🔷 FIRST TAB
                                SingleChildScrollView(
                                  padding: EdgeInsets.all(16.r),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      /// PATIENT SELECTION
                                      Text(
                                        "SELECT PATIENT",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      DropdownButtonFormField<String>(
                                        value: selectedPatientCode,
                                        hint: Text("Select Patient", style: TextStyle(fontSize: 14.sp)),
                                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                                        items: patients
                                            .map(
                                              (p) => DropdownMenuItem(
                                                value: p.patientCode,
                                                child: Text("${p.fullName} (${p.patientCode})"),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (code) {
                                          final p = patients.firstWhere((element) => element.patientCode == code);
                                          setState(() {
                                            selectedPatientCode = code;
                                            billToNameCtrl.text = p.fullName;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                                        ),
                                      ),

                                      SizedBox(height: 12.h),

                                      /// NAME
                                      _field("Invoice / Bill in the name of", billToNameCtrl),

                                      SizedBox(height: 12.h),

                                      /// TITLE + CURRENCY
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _field("Invoice title", invoiceTitleCtrl),
                                          ),
                                          SizedBox(width: 10.w),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16.w,
                                              vertical: 14.h,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(10.r),
                                              color: Colors.white,
                                            ),
                                            child: Text("₹", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 20.h),
                                      const Divider(thickness: 1.2),
                                      SizedBox(height: 10.h),

                                      Text(
                                        "ADD ITEMS",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),

                                      /// ITEM + AMOUNT FORM
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: _field("Particulars / Item Description", itemDescCtrl),
                                          ),
                                          SizedBox(width: 8.w),
                                          Expanded(
                                            flex: 2,
                                            child: TextField(
                                              controller: itemAmountCtrl,
                                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                              style: TextStyle(fontSize: 14.sp),
                                              decoration: InputDecoration(
                                                hintText: "Amount (₹)",
                                                hintStyle: TextStyle(fontSize: 14.sp),
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.r),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 8.h),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton.icon(
                                          onPressed: addLocalItem,
                                          icon: const Icon(Icons.add, color: Colors.white),
                                          label: const Text("Add Item"),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.r),
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 15.h),

                                      /// LOCALLY ADDED ITEMS LIST
                                      if (addedItems.isNotEmpty) ...[
                                        Text(
                                          "Added Items (${addedItems.length})",
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 6.h),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.9),
                                            borderRadius: BorderRadius.circular(10.r),
                                            border: Border.all(color: Colors.grey.shade300),
                                          ),
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: addedItems.length,
                                            separatorBuilder: (context, i) => const Divider(height: 1),
                                            itemBuilder: (context, idx) {
                                              final item = addedItems[idx];
                                              return ListTile(
                                                dense: true,
                                                title: Text(item.description, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                                                trailing: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text("₹${item.amount.round()}", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold)),
                                                    IconButton(
                                                      icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                                                      onPressed: () {
                                                        setState(() {
                                                          addedItems.removeAt(idx);
                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],

                                      SizedBox(height: 30.h),

                                      /// TOTAL + BUTTON
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16.w,
                                              vertical: 10.h,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.green),
                                              borderRadius: BorderRadius.circular(12.r),
                                              color: Colors.white,
                                            ),
                                            child: Text(
                                              "Total Amount ₹ $totalAmount",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () => saveInvoice(context),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(0xFF7B3FCF),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 30.w,
                                                vertical: 12.h,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.r),
                                              ),
                                            ),
                                            child: Text(
                                              "Add",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                /// 🔷 SECOND TAB
                                MoreDetails(
                                  discountTitleCtrl: discountTitleCtrl,
                                  advanceTitleCtrl: advanceTitleCtrl,
                                  taxTitleCtrl: taxTitleCtrl,
                                  dateCtrl: dateCtrl,
                                  remarkCtrl: remarkCtrl,
                                  selectedDiscountAmount: selectedDiscountAmount,
                                  selectedAdvanceAmount: selectedAdvanceAmount,
                                  selectedTaxAmount: selectedTaxAmount,
                                  selectedStatus: selectedStatus,
                                  onDiscountAmountChanged: (v) {
                                    setState(() {
                                      selectedDiscountAmount = v;
                                    });
                                  },
                                  onAdvanceAmountChanged: (v) {
                                    setState(() {
                                      selectedAdvanceAmount = v;
                                    });
                                  },
                                  onTaxAmountChanged: (v) {
                                    setState(() {
                                      selectedTaxAmount = v;
                                    });
                                  },
                                  onStatusChanged: (v) {
                                    setState(() {
                                      selectedStatus = v;
                                    });
                                  },
                                  totalAmount: totalAmount,
                                  onSave: () => saveInvoice(context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Loader overlay
                      BlocBuilder<InvoiceCubit, InvoiceState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            loading: () => Container(
                              color: Colors.black.withOpacity(0.3),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            orElse: () => const SizedBox.shrink(),
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14.sp),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }
}
