import 'package:dartz/dartz.dart';
import 'package:weather_app/core/entities/get_weather_params.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/use_cases/use_case.dart';
import 'package:weather_app/features/home/domain/repositories/weather_repository.dart';

import '../entities/weather.dart';

class Get5DaysWeather extends UseCase<List<Weather>, GetWeatherParams> {
  final WeatherRepository repository;
  Get5DaysWeather(this.repository);

  @override
  Future<Either<Failure, List<Weather>>> call(GetWeatherParams params) async{
    return await repository.get5DaysWeather(params.toRequestParams());
  }
}
