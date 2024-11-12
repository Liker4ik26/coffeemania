import 'package:coffee_repository/src/data/remote/models/models.dart';
import 'package:coffee_repository/src/domain/models/location_domain.dart';

extension LocationDomainMapper on LocationResponse {
  LocationDomain toDomain() {
    return LocationDomain(
      address: address,
      lat: lat,
      lng: lng,
    );
  }
}
