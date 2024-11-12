import 'dart:async';

import 'package:coffee_mania/di/injectable.dart';
import 'package:coffee_mania/src/map/data/app_location_repository.dart';
import 'package:coffee_mania/src/map/domain/model/app_lat_long.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

final appLocationRepositoryProvider = Provider<AppLocationRepository>((ref) {
  return getIt<AppLocationRepository>();
});

final currentLocationProvider = FutureProvider<AppLatLong>((ref) async {
  final locationRepository = ref.watch(appLocationRepositoryProvider);
  return locationRepository.getCurrentLocation();
});

final permissionProvider = FutureProvider<bool>((ref) async {
  final locationRepository = ref.watch(appLocationRepositoryProvider);
  return locationRepository.checkPermission();
});

final mapControllerProvider =
    StateProvider<Completer<YandexMapController>>((ref) {
  return Completer<YandexMapController>();
});
