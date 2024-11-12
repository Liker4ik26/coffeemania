import 'package:coffee_mania/src/map/domain/model/app_lat_long.dart';

abstract interface class AppLocationRepository {
  Future<AppLatLong> getCurrentLocation();

  Future<bool> requestPermission();

  Future<bool> checkPermission();
}
