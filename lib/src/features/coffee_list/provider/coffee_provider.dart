import 'package:coffee_mania/di/injectable.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coffeeRepositoryProvider = Provider<CoffeeRepository>((ref) {
  return getIt<CoffeeRepository>();
});
