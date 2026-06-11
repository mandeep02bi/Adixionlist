// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineRequestBody _$MedicineRequestBodyFromJson(Map<String, dynamic> json) =>
    MedicineRequestBody(
      name: json['name'] as String,
      totalQuantity: json['total_quantity'] as String?,
      frequency: json['frequency'] as String?,
      routeForm: json['route_form'] as String?,
      noOfDays: json['no_of_days'] as String?,
      instructions: json['instructions'] as String?,
      additionalComments: json['additional_comments'] as String?,
    );

Map<String, dynamic> _$MedicineRequestBodyToJson(
  MedicineRequestBody instance,
) => <String, dynamic>{
  'name': instance.name,
  'total_quantity': instance.totalQuantity,
  'frequency': instance.frequency,
  'route_form': instance.routeForm,
  'no_of_days': instance.noOfDays,
  'instructions': instance.instructions,
  'additional_comments': instance.additionalComments,
};
