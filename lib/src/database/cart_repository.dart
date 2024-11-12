import 'package:coffee_repository/coffee_repository.dart';

abstract interface class CartRepository {
  const CartRepository();

  Future<List<CoffeeDomain>> getProducts();

  Future<void> addProduct({required CoffeeDomain product});

  Future<void> removeProduct({required int productId});

  Future<void> clearCart();

  Future<int> getQuantity(CoffeeDomain product);
}
