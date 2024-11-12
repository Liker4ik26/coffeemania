import 'package:coffee_repository/src/data/remote/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_page_response.g.dart';

@JsonSerializable()
class LocationPageResponse {
  const LocationPageResponse({
    required this.data,
  });

  factory LocationPageResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationPageResponseFromJson(json);

  final List<LocationResponse> data;
}
