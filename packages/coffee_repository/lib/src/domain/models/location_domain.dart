import 'package:equatable/equatable.dart';

class LocationDomain extends Equatable {
  const LocationDomain({
    required this.address,
    required this.lat,
    required this.lng,
  });

  final String address;
  final double lat;
  final double lng;

  @override
  List<Object?> get props => [
        address,
        lat,
        lng,
      ];

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'lat': lat,
      'lng': lng,
    };
  }
}
