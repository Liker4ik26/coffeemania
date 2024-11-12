import 'package:coffee_mania/di/database_module.dart';
import 'package:coffee_mania/src/database/cart_repository.dart';
import 'package:coffee_mania/src/database/cart_repository_impl.dart';
import 'package:coffee_mania/src/map/data/app_location_repository.dart';
import 'package:coffee_mania/src/map/data/app_location_repository_impl.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio dio() {
    return Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_URL']!,
      ),
    );
  }

  @lazySingleton
  CartRepository cartRepository(DatabaseModule dbProvider) =>
      CartRepositoryImpl(dbProvider: dbProvider);

  @lazySingleton
  CoffeeApiDataSource coffeeApiDataSource(Dio dio) =>
      CoffeeApiDataSource(dio: dio, cacheManager: DefaultCacheManager());

  @lazySingleton
  CoffeeRepository coffeeRepository(CoffeeApiDataSource dataSource) =>
      CoffeeRepositoryImpl(dataSource: dataSource);

  @lazySingleton
  DatabaseModule databaseModule() => DatabaseModule();

  @lazySingleton
  AppLocationRepository appLocationRepository() => AppLocationRepositoryImpl();
}
