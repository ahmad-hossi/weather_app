import 'package:weather_app/features/home/domain/entities/weather.dart';

class WeatherModel extends Weather {
  final String status;
  final String description;
  final double temp;
  final double tempMin;
  final double tempMax;
  final double feelsLike;
  final double pressure;
  final double humidity;
  final double windSpeed;
  final DateTime dateTime;
  final String cityName;

  WeatherModel({
    required this.status,
    required this.description,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.dateTime,
    required this.cityName,
  }) : super(
            status: status,
            description: description,
            temp: temp,
            tempMin: tempMin,
            tempMax: tempMax,
            feelsLike: feelsLike,
            pressure: pressure,
            humidity: humidity,
            windSpeed: windSpeed,
            dateTime: dateTime,
            cityName: cityName);

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
      status: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      temp: (json['main']['temp'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      pressure: (json['main']['pressure'] as num).toDouble(),
      humidity: (json['main']['humidity'] as num).toDouble(),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      dateTime: json['dt_txt'] != null
          ? DateTime.parse(json['dt_txt'])
          : DateTime.now(),
      cityName: json['name'] ?? '');

  @override
  String toString() {
    return 'WeatherModel{status: $status, description: $description, temp: $temp, tempMin: $tempMin, tempMax: $tempMax, feelsLike: $feelsLike, pressure: $pressure, humidity: $humidity, windSpeed: $windSpeed}';
  }
}
