import 'package:doctor/Core/theme/color_app.dart';
import 'package:doctor/Presentation/Prescription/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreDetails extends StatefulWidget {
  final bool isEdit;

  final TextEditingController discountTitleCtrl;
  final TextEditingController advanceTitleCtrl;
  final TextEditingController taxTitleCtrl;
  final TextEditingController dateCtrl;
  final TextEditingController remarkCtrl;
  
  final String? selectedDiscountAmount;
  final String? selectedAdvanceAmount;
  final String? selectedTaxAmount;
  final String selectedStatus;
  
  final ValueChanged<String?> onDiscountAmountChanged;
  final ValueChanged<String?> onAdvanceAmountChanged;
  final ValueChanged<String?> onTaxAmountChanged;
  final ValueChanged<String> onStatusChanged;
  
  final int totalAmount;
  final VoidCallback onSave;

  const MoreDetails({
    super.key,
    required this.isEdit,
    required this.discountTitleCtrl,
    required this.advanceTitleCtrl,
    required this.taxTitleCtrl,
    required this.dateCtrl,
    required this.remarkCtrl,
    required this.selectedDiscountAmount,
    required this.selectedAdvanceAmount,
    required this.selectedTaxAmount,
    required this.selectedStatus,
    required this.onDiscountAmountChanged,
    required this.onAdvanceAmountChanged,
    required this.onTaxAmountChanged,
    required this.onStatusChanged,
    required this.totalAmount,
    required this.onSave,
  });

  @override
  State<MoreDetails> createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  final List<String> amountOptions = ['0', '50', '100', '200', '500'];
  final List<String> taxOptions = ['0', '5', '12', '18', '28'];
  final List<String> statusOptions = ['To pay', 'Paid', 'None'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9F1F6),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Discount Title + Amount
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextFormField(
                    label: 'Discount Title',
                    hint: 'Discount (e.g. Special Discount)',
                    lableStyle: TextStyle(
                      fontSize: 12.sp,
                      color: ColorApp.labelTextColor,
                    ),
                    controller: widget.discountTitleCtrl,
                    fieldFillColor: Colors.white,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      DropdownButtonFormField<String>(
                        value: widget.selectedDiscountAmount,
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                        items: amountOptions
                            .map((e) => DropdownMenuItem(value: e, child: Text("₹$e")))
                            .toList(),
                        onChanged: widget.onDiscountAmountChanged,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 14.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFFE0E0E0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFFE0E0E0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Advance + Amount
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextFormField(
                    label: 'Advance / partial amount paid',
                    lableStyle: TextStyle(
                      fontSize: 12.sp,
                      color: ColorApp.labelTextColor,
                    ),
                    hint: 'Amount Paid (e.g. Deposit)',
                    controller: widget.advanceTitleCtrl,
                    fieldFillColor: Colors.white,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      DropdownButtonFormField<String>(
                        value: widget.selectedAdvanceAmount,
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                        items: amountOptions
                            .map((e) => DropdownMenuItem(value: e, child: Text("₹$e")))
                            .toList(),
                        onChanged: widget.onAdvanceAmountChanged,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 14.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFFE0E0E0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFFE0E0E0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Tax Title + Amount
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextFormField(
                    label: 'Tax Title',
                    lableStyle: TextStyle(
                      fontSize: 12.sp,
                      color: ColorApp.labelTextColor,
                    ),
                    hint: 'Tax (e.g. GST)',
                    controller: widget.taxTitleCtrl,
                    fieldFillColor: Colors.white,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Percentage',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      DropdownButtonFormField<String>(
                        value: widget.selectedTaxAmount,
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                        items: taxOptions
                            .map((e) => DropdownMenuItem(value: e, child: Text("$e%")))
                            .toList(),
                        onChanged: widget.onTaxAmountChanged,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 14.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFFE0E0E0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFFE0E0E0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Date
            CustomTextFormField(
              label: 'Date',
              hint: 'YYYY-MM-DD',
              controller: widget.dateCtrl,
              lableStyle: TextStyle(
                fontSize: 12.sp,
                color: ColorApp.labelTextColor,
              ),
              fieldFillColor: Colors.white,
              keyboardType: TextInputType.datetime,
            ),

            SizedBox(height: 12.h),

            // Remark
            CustomTextFormField(
              label: 'Remark',
              lableStyle: TextStyle(
                fontSize: 12.sp,
                color: ColorApp.labelTextColor,
              ),
              hint: 'Enter remarks or notes',
              controller: widget.remarkCtrl,
              fieldFillColor: Colors.white,
            ),

            SizedBox(height: 12.h),

            // Status
            Text(
              'STATUS',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8.w,
              ),
            ),
            SizedBox(height: 8.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: statusOptions.map((status) {
                  final isSelected = widget.selectedStatus == status;
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: GestureDetector(
                      onTap: () => widget.onStatusChanged(status),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF7B3FCF)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF7B3FCF)
                                : const Color(0xFFE0E0E0),
                          ),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black54,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 40.h),

            // Total + Add Button
            Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(30.r),
                    color: Colors.white,
                  ),
                  child: Text(
                    'Total Amount ₹ ${widget.totalAmount}',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: widget.onSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B3FCF),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.w,
                      vertical: 14.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text(
                    widget.isEdit ? 'Update' : 'Add',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
