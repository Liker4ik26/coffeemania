import 'package:coffee_mania/src/features/coffee_list/view/coffee_list_screen.dart';
import 'package:coffee_mania/src/features/coffee_shop_list/view/coffee_shop_list_screen.dart';
import 'package:coffee_mania/src/features/coffee_shop_map/view/coffee_shop_map_screen.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  const Routes._();

  static const coffeeListRoute = '/coffee_list';
  static const mapRoute = '/map';
  static const coffeeShopListRoute = '/coffee_shop_list';

  static Map<String, Widget Function(BuildContext)> get all => {
        Routes.coffeeListRoute: (context) => const CoffeeListScreen(),
        Routes.mapRoute: (context) => const CoffeeShopMapScreen(),
        Routes.coffeeShopListRoute: (context) => const CoffeeShopListScreen(),
      };
}
