import 'package:coffee_repository/coffee_repository.dart';

extension CategoryeDomainMapper on CategoryResponse {
  CategoryDomain toDomain() {
    return CategoryDomain(
      id: id,
      slug: slug,
    );
  }
}
