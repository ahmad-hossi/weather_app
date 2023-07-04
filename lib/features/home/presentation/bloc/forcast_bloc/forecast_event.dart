part of 'forecast_bloc.dart';

@immutable
abstract class ForecastEvent {}

class GetWeatherForecast extends ForecastEvent{
  final double lon;
  final double lat;

  GetWeatherForecast({
    required this.lon,
    required this.lat,
  });
}
