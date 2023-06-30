import 'package:dartz/dartz.dart';
import 'package:weather_app/core/entities/get_weather_params.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/home/domain/entities/weather.dart';
import 'package:weather_app/features/home/domain/repositories/weather_repository.dart';
import '../../../../core/use_cases/use_case.dart';

class GetCurrentWeather extends UseCase<Weather, GetWeatherParams> {
  final WeatherRepository _repository;
  GetCurrentWeather(this._repository);

  @override
  Future<Either<Failure, Weather>> call(GetWeatherParams params) async {
    return _repository.getCurrentWeather(params.toRequestParams());
  }
}
