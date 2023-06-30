part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class GetCurrentWeatherEvent extends WeatherEvent {
  final double lon;
  final double lat;

  GetCurrentWeatherEvent({
    required this.lon,
    required this.lat,
  });
}
