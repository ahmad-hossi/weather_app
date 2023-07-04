import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/entities/get_weather_params.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/weather.dart';
import '../../../domain/use_cases/get_5days_weather.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final Get5DaysWeather _get5daysWeather;

  ForecastBloc(this._get5daysWeather) : super(ForecastInitial()) {
    on<GetWeatherForecast>(_onGetWeatherForecast);
  }

  Future<void> _onGetWeatherForecast(
      GetWeatherForecast event, Emitter<ForecastState> emit) async {
    emit(ForecastLoading());
    final eitherResponse = await _get5daysWeather(
        GetWeatherParams(lon: event.lon, lat: event.lat));
    emit(eitherResponse.fold(
            (failure) =>
            ForecastFailed(errorMessage: getErrorMessage(failure.errorType)),
            (forecast) => ForecastLoaded(forecast: forecast)));
  }
}
