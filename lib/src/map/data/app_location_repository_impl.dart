import 'package:coffee_mania/src/map/data/app_location_repository.dart';
import 'package:coffee_mania/src/map/domain/model/app_lat_long.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppLocationRepositoryImpl implements AppLocationRepository {
  final defLocation = const MoscowLocation();

  @override
  Future<bool> checkPermission() {
    return Geolocator.checkPermission()
        .then(
          (value) =>
              value == LocationPermission.always ||
              value == LocationPermission.whileInUse,
        )
        .catchError((_) => false);
  }

  @override
  Future<AppLatLong> getCurrentLocation() async {
    return Geolocator.getCurrentPosition().then((value) {
      return AppLatLong(lat: value.latitude, long: value.longitude);
    }).catchError(
      (_) => defLocation,
    );
  }

  @override
  Future<bool> requestPermission() {
    return Geolocator.requestPermission()
        .then(
          (value) =>
              value == LocationPermission.always ||
              value == LocationPermission.whileInUse,
        )
        .catchError((_) => false);
  }
}
