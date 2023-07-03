import 'package:dartz/dartz.dart';
import 'package:weather_app/core/entities/get_city_location_params.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/use_cases/use_case.dart';
import 'package:weather_app/features/home/domain/entities/location_entity.dart';
import 'package:weather_app/features/home/domain/repositories/weather_repository.dart';

class GetCityLocation extends UseCase<LocationEntity,GetCityLocationParams>{
  final WeatherRepository _repository;


  GetCityLocation(this._repository);

  @override
  Future<Either<Failure, LocationEntity>> call(GetCityLocationParams params) async {
   return await _repository.getCityLocation(params.toRequestParams());
  }

}