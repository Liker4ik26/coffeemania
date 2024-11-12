import 'package:coffee_mania/di/injectable.dart';
import 'package:coffee_mania/src/app.dart';
import 'package:coffee_mania/src/shared_preferences/shared_preferences_repository.dart';
import 'package:coffee_mania/src/shared_preferences/shared_preferences_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AndroidYandexMap.useAndroidViewSurface = false;
  await dotenv.load();

  configureDependencies();

  getIt
    ..registerLazySingletonAsync<SharedPreferences>(
      () async => SharedPreferences.getInstance(),
    )
    ..registerLazySingleton<SharedPreferencesRepository>(
      () => SharedPreferencesRepositoryImpl(getIt<SharedPreferences>()),
    );
  await getIt.isReady<SharedPreferences>();
  runApp(const App());
}
