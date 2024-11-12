import 'package:coffee_repository/coffee_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categories_page_response.g.dart';

@JsonSerializable()
class CategoriesPageResponse {
  const CategoriesPageResponse({
    required this.data,
  });

  factory CategoriesPageResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesPageResponseFromJson(json);

  final List<CategoryResponse> data;
}
