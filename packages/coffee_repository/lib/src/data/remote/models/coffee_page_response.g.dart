// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_page_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoffeePageResponse _$CoffeePageResponseFromJson(Map<String, dynamic> json) =>
    CoffeePageResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => CoffeeResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoffeePageResponseToJson(CoffeePageResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

CoffeeResponse _$CoffeeResponseFromJson(Map<String, dynamic> json) =>
    CoffeeResponse(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      category:
          CategoryResponse.fromJson(json['category'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String?,
      prices: (json['prices'] as List<dynamic>)
          .map((e) => PriceResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoffeeResponseToJson(CoffeeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'imageUrl': instance.imageUrl,
      'prices': instance.prices,
    };

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      id: (json['id'] as num).toInt(),
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
    };

PriceResponse _$PriceResponseFromJson(Map<String, dynamic> json) =>
    PriceResponse(
      value: json['value'] as String,
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$PriceResponseToJson(PriceResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'currency': instance.currency,
    };

LocationResponse _$LocationResponseFromJson(Map<String, dynamic> json) =>
    LocationResponse(
      address: json['address'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$LocationResponseToJson(LocationResponse instance) =>
    <String, dynamic>{
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
    };
