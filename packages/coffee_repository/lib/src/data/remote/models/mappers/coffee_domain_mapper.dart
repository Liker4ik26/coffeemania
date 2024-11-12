import 'package:coffee_repository/coffee_repository.dart';

extension CoffeeDomainMapper on CoffeeResponse {
  CoffeeDomain toDomain() {
    return CoffeeDomain(
      id: id,
      name: name,
      description: description,
      category: category.toDomain(),
      imageUrl: imageUrl,
      prices: prices.map((e) => e.toDomain()).toList(),
    );
  }
}
