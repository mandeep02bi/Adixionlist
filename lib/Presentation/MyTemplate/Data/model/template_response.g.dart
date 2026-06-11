// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemplateResponse _$TemplateResponseFromJson(Map<String, dynamic> json) =>
    TemplateResponse(
      status: json['status'] as bool?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TemplateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TemplateResponseToJson(TemplateResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };
