import 'package:dio/dio.dart';
import 'package:doctor/Core/networking/api_const.dart';
import 'package:doctor/Presentation/Invoice/data/models/invoice_request_body.dart';
import 'package:doctor/Presentation/Invoice/data/models/invoice_item_request_body.dart';
import 'package:doctor/Presentation/Invoice/data/models/invoice_response.dart';
import 'package:retrofit/retrofit.dart';

part 'invoice_api_service.g.dart';

@RestApi(baseUrl: ApiConst.baseUrl)
abstract class InvoiceApiService {
  factory InvoiceApiService(Dio dio, {String? baseUrl}) = _InvoiceApiService;

  @POST(ApiConst.invoices)
  Future<InvoiceResponse> createInvoice(
    @Body() InvoiceRequestBody body,
  );

  @GET(ApiConst.invoices)
  Future<InvoiceListResponse> getInvoices(
    @Query('patient_code') String? patientCode,
    @Query('sort') String? sort,
  );

  @GET('${ApiConst.invoices}/{id}')
  Future<InvoiceResponse> getInvoiceDetails(
    @Path('id') int id,
  );

  @POST('${ApiConst.invoices}/{id}/items')
  Future<InvoiceResponse> addInvoiceItem(
    @Path('id') int id,
    @Body() InvoiceItemRequestBody body,
  );

  @DELETE('${ApiConst.invoices}/{id}')
  Future<InvoiceResponse> deleteInvoice(
    @Path('id') int id,
  );

  @PUT('${ApiConst.invoices}/{id}')
  Future<InvoiceResponse> updateInvoice(
      @Path('id') int id,
      @Body() InvoiceRequestBody body,
      );
}
