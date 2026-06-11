import 'package:doctor/Core/networking/api_result.dart';
import 'package:doctor/Presentation/MyTemplate/Data/repository/template_repository.dart';
import 'package:doctor/Presentation/MyTemplate/cubit/template_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemplateCubit extends Cubit<TemplateState> {
  final TemplateRepo templateRepo;

  TemplateCubit({required this.templateRepo}) : super(TemplateInitial());

  Future<void> getTemplates(String type) async {
    emit(TemplateLoading());

    final result = await templateRepo.getTemplates(type: type);

    result.when(
      success: (response) {
        emit(TemplateLoaded(response.data ?? []));
      },
      error: (error) {
        emit(TemplateError(error.toString()));
      },
    );
  }

  Future<void> getTemplateDetails(int id) async {
    emit(TemplateLoading());

    final result = await templateRepo.getTemplateDetails(id);

    result.when(
      success: (template) {
        emit(TemplateDetailsLoaded(template));
      },
      error: (error) {
        emit(TemplateError(error.toString()));
      },
    );
  }

  Future<bool> createTemplate({
    required String type,
    required String title,
    required String content,
  }) async {
    final result = await templateRepo.createTemplate(
      type: type,
      title: title,
      content: content,
    );

    bool success = false;

    result.when(
      success: (_) {
        success = true;
      },
      error: (_) {
        success = false;
      },
    );

    return success;
  }
}
