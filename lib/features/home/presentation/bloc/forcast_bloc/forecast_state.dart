part of 'forecast_bloc.dart';

@immutable
abstract class ForecastState {}

class ForecastInitial extends ForecastState {}

class ForecastLoading extends ForecastState {}

class ForecastLoaded extends ForecastState {
  final List<Weather> forecast;

  ForecastLoaded({required this.forecast});
}

class ForecastFailed extends ForecastState {
  final String errorMessage;

  ForecastFailed({required this.errorMessage});
}
