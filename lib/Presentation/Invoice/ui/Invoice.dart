import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Presentation/Invoice/logic/invoice_cubit.dart';
import 'package:doctor/Presentation/Invoice/logic/invoice_state.dart';
import 'package:doctor/Presentation/Invoice/data/models/invoice_response.dart';
import 'package:doctor/Presentation/Invoice/ui/Addinvoce.dart';
import 'package:doctor/widgets/Common/Appheader.dart';
import 'package:doctor/widgets/Invoice/Invoicecard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Invoice extends StatefulWidget {
  const Invoice({super.key});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<InvoiceCubit>(
      create: (context) => getIt<InvoiceCubit>()..getInvoices(),
      child: Scaffold(
        backgroundColor: const Color(0xFFE9F1F6),
        body: Builder(
          builder: (context) {
            return Column(
              children: [
                /// 🔷 HEADER
                AppHeader(
                  title: "List of Invoice",
                  onBack: () => Navigator.pop(context),
                  onAdd: () async {
                    final result = await Get.to(() => const Addinvoce());
                    if (result == true) {
                      // Refresh list on return
                      if (context.mounted) {
                        context.read<InvoiceCubit>().getInvoices();
                      }
                    }
                  },
                  backgroundImage: "assets/images/background/P.jpg",
                ),

                Expanded(
                  child: BlocBuilder<InvoiceCubit, InvoiceState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loading: () => const Center(child: CircularProgressIndicator()),
                        fetchInvoicesError: (errorMsg) => Center(
                          child: Text(
                            errorMsg,
                            style: TextStyle(fontSize: 14.sp, color: Colors.red),
                          ),
                        ),
                        fetchInvoicesSuccess: (data) {
                          final list = (data as InvoiceListResponse).data ?? [];

                          if (list.isEmpty) {
                            return Center(
                              child: Text(
                                "No Invoices Found",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            );
                          }

                          return ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final item = list[index];

                              // Safe parse total amount
                              final amountDouble = double.tryParse(item.totalAmount ?? '0') ?? 0.0;
                              final amountInt = amountDouble.round();

                              return InvoiceCard(
                                name: item.billToName ?? item.patientName ?? "Unknown Patient",
                                patientId: item.patientCode ?? "PT-000",
                                age: 27, // backend does not provide age, using standard default
                                amount: amountInt,
                                isPaid: item.status?.toLowerCase() == 'paid',
                              );
                            },
                          );
                        },
                        orElse: () => const Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}