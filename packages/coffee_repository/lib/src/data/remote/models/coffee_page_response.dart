import 'package:json_annotation/json_annotation.dart';

part 'coffee_page_response.g.dart';

@JsonSerializable()
class CoffeePageResponse {
  const CoffeePageResponse({
    required this.data,
  });

  factory CoffeePageResponse.fromJson(Map<String, dynamic> json) =>
      _$CoffeePageResponseFromJson(json);

  final List<CoffeeResponse> data;
}

@JsonSerializable()
class CoffeeResponse {
  const CoffeeResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    this.imageUrl,
    required this.prices,
  });

  factory CoffeeResponse.fromJson(Map<String, dynamic> json) =>
      _$CoffeeResponseFromJson(json);

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'category')
  final CategoryResponse category;

  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  @JsonKey(name: 'prices')
  final List<PriceResponse> prices;
}

@JsonSerializable()
class CategoryResponse {
  const CategoryResponse({
    required this.id,
    required this.slug,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'slug')
  final String slug;
}

@JsonSerializable()
class PriceResponse {
  const PriceResponse({
    required this.value,
    required this.currency,
  });

  factory PriceResponse.fromJson(Map<String, dynamic> json) =>
      _$PriceResponseFromJson(json);

  @JsonKey(name: 'value')
  final String value;

  @JsonKey(name: 'currency')
  final String currency;
}

@JsonSerializable()
class LocationResponse {
  const LocationResponse({
    required this.address,
    required this.lat,
    required this.lng,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseFromJson(json);

  @JsonKey(name: 'address')
  final String address;

  @JsonKey(name: 'lat')
  final double lat;

  @JsonKey(name: 'lng')
  final double lng;
}
