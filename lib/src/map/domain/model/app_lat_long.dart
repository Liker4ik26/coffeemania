class AppLatLong {
  const AppLatLong({
    required this.lat,
    required this.long,
  });

  final double lat;
  final double long;
}

class MoscowLocation extends AppLatLong {
  const MoscowLocation({
    super.lat = 55.7522200,
    super.long = 37.6155600,
  });
}
