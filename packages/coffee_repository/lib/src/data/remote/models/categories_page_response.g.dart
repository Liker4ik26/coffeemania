// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_page_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesPageResponse _$CategoriesPageResponseFromJson(
        Map<String, dynamic> json) =>
    CategoriesPageResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => CategoryResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoriesPageResponseToJson(
        CategoriesPageResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
