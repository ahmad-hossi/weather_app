import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/home/domain/entities/weather.dart';

abstract class WeatherRepository{
  Future<Either<Failure,Weather>> getCurrentWeather(String requestParams);
  Future<Either<Failure,List<Weather>>> get5DaysWeather(String requestParams);
}