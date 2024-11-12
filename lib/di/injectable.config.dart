// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coffee_mania/di/database_module.dart' as _i5;
import 'package:coffee_mania/di/register_module.dart' as _i12;
import 'package:coffee_mania/src/database/cart_repository.dart' as _i11;
import 'package:coffee_mania/src/database/cart_repository_impl.dart' as _i7;
import 'package:coffee_mania/src/map/data/app_location_repository.dart' as _i6;
import 'package:coffee_mania/src/map/data/app_location_repository_impl.dart'
    as _i3;
import 'package:coffee_mania/src/shared_preferences/shared_preferences_repository_impl.dart'
    as _i8;
import 'package:coffee_repository/coffee_repository.dart' as _i10;
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.AppLocationRepositoryImpl>(
        () => _i3.AppLocationRepositoryImpl());
    gh.lazySingleton<_i4.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i5.DatabaseModule>(() => registerModule.databaseModule());
    gh.lazySingleton<_i6.AppLocationRepository>(
        () => registerModule.appLocationRepository());
    gh.factory<_i7.CartRepositoryImpl>(
        () => _i7.CartRepositoryImpl(dbProvider: gh<_i5.DatabaseModule>()));
    gh.factory<_i8.SharedPreferencesRepositoryImpl>(
        () => _i8.SharedPreferencesRepositoryImpl(gh<_i9.SharedPreferences>()));
    gh.lazySingleton<_i10.CoffeeApiDataSource>(
        () => registerModule.coffeeApiDataSource(gh<_i4.Dio>()));
    gh.lazySingleton<_i10.CoffeeRepository>(
        () => registerModule.coffeeRepository(gh<_i10.CoffeeApiDataSource>()));
    gh.lazySingleton<_i11.CartRepository>(
        () => registerModule.cartRepository(gh<_i5.DatabaseModule>()));
    return this;
  }
}

class _$RegisterModule extends _i12.RegisterModule {}
