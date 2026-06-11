import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Core/networking/error_handler.dart';

import 'package:doctor/Presentation/MyTemplate/Data/api/template_service.dart';
import 'package:doctor/Presentation/MyTemplate/Data/model/template_model.dart';
import 'package:doctor/Presentation/MyTemplate/Data/model/template_response.dart';

class TemplateRepo {
  final TemplateApiService templateApiService;

  const TemplateRepo({required this.templateApiService});

  Future<ApiResult<TemplateResponse>> getTemplates({
    required String type,
  }) async {
    try {
      final response = await templateApiService.getTemplates(type);

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<TemplateModel>> getTemplateDetails(int id) async {
    try {
      final response = await templateApiService.getTemplateDetails(id);

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<dynamic>> createTemplate({
    required String type,
    required String title,
    required String content,
  }) async {
    try {
      final response = await templateApiService.createTemplate({
        "type": type,
        "title": title,
        "content": content,
      });

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ErrorHandler.handle(error));
    }
  }
}
