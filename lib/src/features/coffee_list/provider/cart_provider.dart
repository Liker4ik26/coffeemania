import 'package:coffee_mania/di/injectable.dart';
import 'package:coffee_mania/src/database/database.dart';
import 'package:coffee_mania/src/extensions/context_extensions.dart';
import 'package:coffee_mania/src/features/coffee_list/provider/coffee_provider.dart';
import 'package:coffee_mania/src/features/coffee_list/provider/error_provider.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return getIt<CartRepository>();
});

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  final cartRepository = ref.watch(cartRepositoryProvider);
  final coffeeRepository = ref.watch(coffeeRepositoryProvider);
  return CartNotifier(cartRepository, coffeeRepository, ref);
});

class CartState {
  CartState({
    this.items = const [],
    this.quantities = const {},
    this.totalCost = 0.0,
  });

  final List<CoffeeDomain> items;
  final Map<int, int> quantities;
  final double totalCost;

  List<CoffeeDomain> get expandedItems {
    return items
        .expand(
          (product) => List.filled(
            quantities[product.id] ?? 0,
            product,
          ),
        )
        .toList();
  }

  int getQuantity(int productId) => quantities[productId] ?? 0;
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier(
    this.cartRepository,
    this.coffeeRepository,
    this.ref,
  ) : super(CartState()) {
    _initialize();
  }

  final CartRepository cartRepository;
  final CoffeeRepository coffeeRepository;
  final Ref ref;

  Future<void> _initialize() async {
    await _updateCartState();
  }

  Future<void> addProduct(CoffeeDomain product) async {
    try {
      final currentQuantity = state.getQuantity(product.id);

      if (currentQuantity < 10) {
        await cartRepository.addProduct(product: product);
        await _updateCartState();
      }
    } catch (e) {
      ref.read(errorProvider.notifier).setError('$e');
    }
  }

  Future<void> removeProduct(CoffeeDomain product) async {
    try {
      final currentQuantity = state.getQuantity(product.id);

      if (currentQuantity > 0) {
        await cartRepository.removeProduct(productId: product.id);
        await _updateCartState();
      }
    } catch (e) {
      ref.read(errorProvider.notifier).setError('$e');
    }
  }

  Future<void> clearCart() async {
    try {
      await cartRepository.clearCart();
      state = CartState(items: [], quantities: {}, totalCost: 0);
    } catch (e) {
      ref.read(errorProvider.notifier).setError('$e');
    }
  }

  Future<void> _updateCartState() async {
    try {
      final updatedItems = await cartRepository.getProducts();
      final quantities = <int, int>{};
      var totalCost = 0.0;

      for (final product in updatedItems) {
        final price = double.parse(product.prices[0].value);
        quantities[product.id] = (quantities[product.id] ?? 0) + 1;
        totalCost += price;
      }

      state = CartState(
        items: updatedItems,
        quantities: quantities,
        totalCost: double.parse(totalCost.toStringAsFixed(2)),
      );
    } catch (e) {
      ref.read(errorProvider.notifier).setError('$e');
    }
  }

  Future<void> createOrder({
    required Map<String, int> positions,
    required BuildContext context,
  }) async {
    try {
      final success = await coffeeRepository.createOrder(positions: positions);
      if (success) {
        await clearCart();
        ref
            .read(errorProvider.notifier)
            .setError('${context.tr.orderCreated} ✅ ');
      }
    } catch (e) {
      ref.read(errorProvider.notifier).setError('${context.tr.errorOrder}: $e');
    }
  }
}
