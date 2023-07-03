import 'package:weather_app/features/home/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  final double lat;
  final double lon;
  final String country;
  final String cityName;
  final String state;

  LocationModel(
      {required this.lat,
      required this.lon,
      required this.country,
      required this.cityName,
      required this.state})
      : super(lat: lat, lon: lon, country: country, cityName: cityName,state: state);

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      country: json['country'],
      cityName: json['name'],
       state: json['state']
  );

  @override
  String toString() {
    return 'LocationModel{lat: $lat, lon: $lon, country: $country, name: $cityName}';
  }
}
