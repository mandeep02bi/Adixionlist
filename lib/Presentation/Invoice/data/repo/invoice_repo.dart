import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Core/networking/error_handler.dart';
import 'package:doctor/Presentation/Invoice/data/api/invoice_api_service.dart';
import 'package:doctor/Presentation/Invoice/data/models/invoice_request_body.dart';
import 'package:doctor/Presentation/Invoice/data/models/invoice_item_request_body.dart';
import 'package:doctor/Presentation/Invoice/data/models/invoice_response.dart';

class InvoiceRepo {
  final InvoiceApiService invoiceApiService;
  const InvoiceRepo({required this.invoiceApiService});

  Future<ApiResult<InvoiceResponse>> createInvoice(
    InvoiceRequestBody body,
  ) async {
    try {
      final response = await invoiceApiService.createInvoice(body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<InvoiceListResponse>> getInvoices({
    String? patientCode,
    String? sort,
  }) async {
    try {
      final response = await invoiceApiService.getInvoices(patientCode, sort);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<InvoiceResponse>> getInvoiceDetails(int id) async {
    try {
      final response = await invoiceApiService.getInvoiceDetails(id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<InvoiceResponse>> addInvoiceItem(
    int id,
    InvoiceItemRequestBody body,
  ) async {
    try {
      final response = await invoiceApiService.addInvoiceItem(id, body);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<InvoiceResponse>> deleteInvoice(int id) async {
    try {
      final response = await invoiceApiService.deleteInvoice(id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }
}
