import 'package:doctor/Presentation/Invoice/ui/Addinvoce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../Core/di/dependancy_injection.dart';

import '../logic/invoice_cubit.dart';
import '../logic/invoice_state.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  final int invoiceId;

  const InvoiceDetailsScreen({super.key, required this.invoiceId});

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "-";

    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<InvoiceCubit>()..getInvoiceDetails(widget.invoiceId),
      child: BlocListener<InvoiceCubit, InvoiceState>(
        listener: (context, state) {

          state.maybeWhen(

            deleteInvoiceSuccess: (data) {

              Get.snackbar(
                "Success",
                "Invoice deleted successfully",
                backgroundColor: Colors.red,
                colorText: Colors.white
              );

              Navigator.pop(context, true);
            },

            deleteInvoiceError: (error) {

              Get.snackbar(
                "Error",
                error,
              );
            },

            orElse: () {},
          );
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFFFFFFF),
        
          appBar: AppBar(
            title: Text("Invoice Details"),
            backgroundColor: Color(0xff2F9C9D),
            foregroundColor: Colors.white,
          ),
        
          body: BlocBuilder<InvoiceCubit, InvoiceState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
        
                fetchInvoicesSuccess: (response) {
                  final invoice = response.data;
                  if (invoice == null) {
                    return const Center(child: Text("Invoice not found"));
                  }
        
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
        
                    child: Column(
                      children: [
                        _buildInfoCard(invoice),
        
                        const SizedBox(height: 12),
        
                        _buildItemsCard(invoice),
        
                        const SizedBox(height: 12),
        
                        _buildSummaryCard(invoice),
        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () async {
                                final result = await Get.to(
                                      () => Addinvoce(
                                    isEdit: true,
                                    invoice: invoice,
                                  ),
                                );
        
                                if (result == true) {
                                  context.read<InvoiceCubit>()
                                      .getInvoiceDetails(widget.invoiceId);
                                }
                              },
                              child: Text(
                                "Update",
                                style: TextStyle(
                                  color: Color(0xff2F9C9D),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(width: 5,),
                            TextButton(
                              onPressed: () {

                                _showDeleteConfirmationDialog(context, invoice.id);


        
                              },
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
        
                orElse: () {
                  return const SizedBox();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(invoice) {
    return Card(
      color: Color(0xffF9FCFF),
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              invoice.invoiceTitle ?? "",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            _row("Bill To", invoice.billToName ?? ""),

            _row("Patient", invoice.patientName ?? ""),

            _row("Invoice Date", formatDate(invoice.invoiceDate)),

            _row("Currency", invoice.currency ?? ""),

            _row("Status", invoice.status ?? ""),

            _row("Remark", invoice.remark ?? ""),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsCard(invoice) {
    final items = invoice.items ?? [];

    return Card(
      color: Color(0xffF9FCFF),
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "Invoice Items",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              itemCount: items.length,

              separatorBuilder: (_, __) => const Divider(),

              itemBuilder: (context, index) {
                final item = items[index];

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Expanded(child: Text(item.description ?? "")),

                    Text("₹ ${item.amount}"),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(invoice) {
    return Card(
      color: Color(0xffF9FCFF),
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            _row("Discount", invoice.discountValue?.toString() ?? "0"),

            _row("Advance Paid", invoice.advanceAmount?.toString() ?? "0"),

            _row("Tax", invoice.taxValue?.toString() ?? "0"),

            const Divider(),

            _row(
              "Total Amount",
              invoice.totalAmount?.toString() ?? "0",
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(title),

          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int invoiceId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Confirm Delete",style: TextStyle(fontWeight: FontWeight.w600),),
          content: const Text("Are you sure you want to delete this invoice?"),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                "Cancel",
                style: TextStyle(  color: Color(0xff2F9C9D),fontWeight: FontWeight.bold),
              ),
            ),
            // Delete Button
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.pop(dialogContext);
                // Call the delete method from the original context
                context.read<InvoiceCubit>().deleteInvoice(invoiceId);
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
