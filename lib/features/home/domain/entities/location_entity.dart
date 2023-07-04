class LocationEntity {
  final double lat;
  final double lon;
  final String country;
  final String cityName;
  final String? state;

  LocationEntity(
      {required this.lat,
      required this.lon,
      required this.country,
      required this.cityName,
      required this.state});
}
