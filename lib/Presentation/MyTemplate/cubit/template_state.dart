import 'package:doctor/Presentation/MyTemplate/Data/model/template_model.dart';

abstract class TemplateState {}

class TemplateInitial extends TemplateState {}

class TemplateLoading extends TemplateState {}

class TemplateLoaded extends TemplateState {
  final List<TemplateModel> templates;

  TemplateLoaded(this.templates);
}

class TemplateDetailsLoaded extends TemplateState {
  final TemplateModel template;

  TemplateDetailsLoaded(this.template);
}

class TemplateError extends TemplateState {
  final String message;

  TemplateError(this.message);
}
