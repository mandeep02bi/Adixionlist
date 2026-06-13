import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Presentation/Invoice/data/models/invoice_request_body.dart';
import 'package:doctor/Presentation/Invoice/data/models/invoice_item_request_body.dart';
import 'package:doctor/Presentation/Invoice/data/repo/invoice_repo.dart';
import 'package:doctor/Presentation/Patient/data/repo/patient_repo.dart';
import 'package:doctor/Presentation/Invoice/logic/invoice_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final InvoiceRepo invoiceRepo;
  final PatientRepo patientRepo;

  InvoiceCubit({
    required this.invoiceRepo,
    required this.patientRepo,
  }) : super(const InvoiceState.initial());

  // Fetch Invoices List
  void getInvoices({String? patientCode, String? sort}) async {
    emit(const InvoiceState.loading());
    final response = await invoiceRepo.getInvoices(
      patientCode: patientCode,
      sort: sort,
    );

    response.when(
      success: (data) {
        emit(InvoiceState.fetchInvoicesSuccess(data));
      },
      error: (error) {
        emit(InvoiceState.fetchInvoicesError(error: error.failure.message));
      },
    );
  }

  // Create Invoice and upload items sequentially
  void createInvoice(InvoiceRequestBody body, List<InvoiceItemRequestBody> items) async {
    emit(const InvoiceState.loading());
    final response = await invoiceRepo.createInvoice(body);

    await response.when(
      success: (data) async {
        final invoiceId = data.data?.id;
        if (invoiceId != null && items.isNotEmpty) {
          for (final item in items) {
            final itemResult = await invoiceRepo.addInvoiceItem(invoiceId, item);
            itemResult.when(
              success: (_) {},
              error: (_) {
              },
            );
          }
        }
        emit(InvoiceState.createInvoiceSuccess(data));
      },
      error: (error) async {
        emit(InvoiceState.createInvoiceError(error: error.failure.message));
      },
    );
  }

  // Fetch Patients for Dropdown selection
  void getPatients() async {
    emit(const InvoiceState.loading());
    final response = await patientRepo.getPatients();

    response.when(
      success: (data) {
        emit(InvoiceState.fetchPatientsSuccess(data));
      },
      error: (error) {
        emit(InvoiceState.fetchPatientsError(error: error.failure.message));
      },
    );
  }


  void getInvoiceDetails(int id) async {
    emit(const InvoiceState.loading());

    final response = await invoiceRepo.getInvoiceDetails(id);

    response.when(
      success: (data) {
        emit(InvoiceState.fetchInvoicesSuccess(data));
      },
      error: (error) {
        emit(
          InvoiceState.fetchInvoicesError(
            error: error.failure.message,
          ),
        );
      },
    );
  }
  Future<void> updateInvoice(
      int id,
      InvoiceRequestBody body,
      List<InvoiceItemRequestBody> items,
      ) async {

    emit(const InvoiceState.loading());

    final response =
    await invoiceRepo.updateInvoice(id, body);

    await response.when(
      success: (data) async {

        emit(
          InvoiceState.updateInvoiceSuccess(data),
        );
      },
      error: (error) {
        emit(
          InvoiceState.updateInvoiceError(
            error: error.failure.message,
          ),
        );
      },
    );
  }


  void deleteInvoice(int id) async {
    emit(const InvoiceState.loading());

    final response =
    await invoiceRepo.deleteInvoice(id);

    response.when(
      success: (data) {
        emit(
          InvoiceState.deleteInvoiceSuccess(data),
        );
      },
      error: (error) {
        emit(
          InvoiceState.deleteInvoiceError(
            error: error.failure.message,
          ),
        );
      },
    );
  }

}
