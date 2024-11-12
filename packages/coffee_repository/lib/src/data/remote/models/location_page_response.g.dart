// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_page_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationPageResponse _$LocationPageResponseFromJson(
        Map<String, dynamic> json) =>
    LocationPageResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => LocationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationPageResponseToJson(
        LocationPageResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
