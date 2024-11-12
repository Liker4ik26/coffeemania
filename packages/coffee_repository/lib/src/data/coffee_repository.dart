import 'package:coffee_repository/coffee_repository.dart';

abstract interface class CoffeeRepository {
  const CoffeeRepository();

  Future<List<CoffeeDomain>> getProducts();

  Future<List<LocationDomain>> getLocations();

  Future<List<CategoryDomain>> getCategories();

  Future<bool> createOrder({
    required Map<String, int> positions,
  });
}
