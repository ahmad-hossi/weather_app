import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/core/entities/get_weather_params.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/home/domain/use_cases/get_5days_weather.dart';
import '../../../domain/entities/weather.dart';
import '../../../domain/use_cases/get_current_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather _getCurrentWeather;
  double? lat;
  double? lon;

  WeatherBloc(this._getCurrentWeather) : super(WeatherInitial()) {
    on<GetCurrentWeatherEvent>(_onGetCurrentWeather);
  }
  Future<void> _onGetCurrentWeather(
      GetCurrentWeatherEvent event, Emitter<WeatherState> emit) async {
    if (event.lon == null && lon == null || event.lat == null && lat == null) {
      print('hi null');
      return;
    }
    emit(WeatherLoading());
    final eitherResponse = await _getCurrentWeather(
        GetWeatherParams(lon: event.lon ?? lat!, lat: event.lat ?? lon!));
    emit(eitherResponse.fold(
        (failure) =>
            WeatherFailed(errorMessage: getErrorMessage(failure.errorType)),
        (weather) {
      lat = event.lat ?? lat;
      lon = event.lon ?? lon;
      print('lat  $lat');
      return WeatherLoaded(weather: weather);
    }));
  }
}
