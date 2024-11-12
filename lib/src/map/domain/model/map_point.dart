import 'package:equatable/equatable.dart';

class MapPoint extends Equatable {
  const MapPoint({
    required this.name,
    required this.latitude,
    required this.longitude,
    this.image,
    this.scale,
  });

  final String name;

  final double latitude;

  final double longitude;

  final String? image;

  final double? scale;

  @override
  List<Object?> get props => [name, latitude, longitude];
}
