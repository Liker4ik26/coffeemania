import 'package:coffee_repository/coffee_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CoffeeRepositoryImpl implements CoffeeRepository {
  CoffeeRepositoryImpl({required this.dataSource});

  final CoffeeApiDataSource dataSource;

  @override
  Future<List<CoffeeDomain>> getProducts() async {
    final products = await dataSource.getProducts();
    return products.data.map((product) => product.toDomain()).toList();
  }

  @override
  Future<List<CategoryDomain>> getCategories() async {
    final categories = await dataSource.getCategories();
    return categories.data.map((category) => category.toDomain()).toList();
  }

  @override
  Future<bool> createOrder({
    required Map<String, int> positions,
  }) async {
    final response =
        await dataSource.createOrder(positions, '<FCM Registration Token>');
    return response;
  }

  @override
  Future<List<LocationDomain>> getLocations() async {
    final locations = await dataSource.getLocations();
    return locations.data.map((location) => location.toDomain()).toList();
  }
}
