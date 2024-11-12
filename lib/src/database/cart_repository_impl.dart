import 'package:coffee_mania/di/database_module.dart';
import 'package:coffee_mania/src/database/cart_repository.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl({
    required this.dbProvider,
  });

  final DatabaseModule dbProvider;

  @override
  Future<void> addProduct({required CoffeeDomain product}) async {
    final db = await dbProvider.database;
    final currentQuantityResult = await db.query(
      'cart',
      where: 'id_product = ?',
      whereArgs: [product.id],
    );

    final currentQuantity = currentQuantityResult.length;

    if (currentQuantity < 10) {
      await db.insert('cart', product.toMap());
    }
  }

  @override
  Future<List<CoffeeDomain>> getProducts() async {
    final db = await dbProvider.database;
    final productList = await db.query('cart');
    return productList.map(CoffeeDomain.fromMap).toList();
  }

  @override
  Future<void> removeProduct({required int productId}) async {
    final db = await dbProvider.database;

    final result = await db.query(
      'cart',
      where: 'id_product = ?',
      whereArgs: [productId],
      limit: 1,
    );

    if (result.isNotEmpty) {
      final idToDelete = result.first['id'];
      await db.delete(
        'cart',
        where: 'id = ?',
        whereArgs: [idToDelete],
      );
    }
  }

  @override
  Future<void> clearCart() async {
    final db = await dbProvider.database;

    await db.delete('cart');
  }

  @override
  Future<int> getQuantity(CoffeeDomain product) async {
    final db = await dbProvider.database;
    final result = await db.query(
      'cart',
      where: 'id = ?',
      whereArgs: [product.id],
    );
    return result.length;
  }
}
