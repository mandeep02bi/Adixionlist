// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_erro_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiErroModel _$ApiErroModelFromJson(Map<String, dynamic> json) => ApiErroModel(
  status: json['status'] as bool,
  statusCode: (json['status_code'] as num).toInt(),
  message: json['message'] as String,
  data: json['data'],
);

Map<String, dynamic> _$ApiErroModelToJson(ApiErroModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_code': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };
