// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_test_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabTestRequestBody _$LabTestRequestBodyFromJson(Map<String, dynamic> json) =>
    LabTestRequestBody(
      testName: json['test_name'] as String,
      additionalComments: json['additional_comments'] as String?,
    );

Map<String, dynamic> _$LabTestRequestBodyToJson(LabTestRequestBody instance) =>
    <String, dynamic>{
      'test_name': instance.testName,
      'additional_comments': instance.additionalComments,
    };
