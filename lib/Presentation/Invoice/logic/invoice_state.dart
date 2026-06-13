import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_state.freezed.dart';

@freezed
class InvoiceState<T> with _$InvoiceState<T> {
  const factory InvoiceState.initial() = _Initial;
  
  const factory InvoiceState.loading() = Loading;
  
  // Invoices Fetch
  const factory InvoiceState.fetchInvoicesSuccess(T data) = FetchInvoicesSuccess<T>;
  const factory InvoiceState.fetchInvoicesError({required String error}) = FetchInvoicesError;

  // Invoice Create
  const factory InvoiceState.createInvoiceSuccess(T data) = CreateInvoiceSuccess<T>;
  const factory InvoiceState.createInvoiceError({required String error}) = CreateInvoiceError;

  // Patients Fetch
  const factory InvoiceState.fetchPatientsSuccess(T data) = FetchPatientsSuccess<T>;
  const factory InvoiceState.fetchPatientsError({required String error}) = FetchPatientsError;

  // Update
  const factory InvoiceState.updateInvoiceSuccess(T data)
  = UpdateInvoiceSuccess<T>;

  const factory InvoiceState.updateInvoiceError({
    required String error,
  }) = UpdateInvoiceError;

  // Delete
  const factory InvoiceState.deleteInvoiceSuccess(T data)
  = DeleteInvoiceSuccess<T>;

  const factory InvoiceState.deleteInvoiceError({
    required String error,
  }) = DeleteInvoiceError;
}
