import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/home/domain/entities/location_entity.dart';
import 'package:weather_app/features/home/domain/entities/weather.dart';
import 'package:weather_app/features/home/domain/repositories/weather_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../data_sources/weather_remote_date_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final NetworkInfo _networkInfo;
  final WeatherRemoteDataSource _remoteDataSource;
  WeatherRepositoryImpl(this._networkInfo, this._remoteDataSource);

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(
      String requestParams) async {
    if (await _networkInfo.isConnected) {
      try {
        return Right(await _remoteDataSource.getCurrentWeather(requestParams));
      } on ServerException {
        return const Left(Failure(errorType: ErrorType.serverError));
      } on UnauthorizedException{
        return const Left(Failure(errorType: ErrorType.notAuthorisedError));
      } on WrongLonOrLatException{
        return const Left(Failure(errorType: ErrorType.wrongInformationError));
      }
    } else {
      return const Left(Failure(errorType: ErrorType.internetConnection));
    }
  }

  @override
  Future<Either<Failure, List<Weather>>> get5DaysWeather(String requestParams) {
    // TODO: implement get5DaysWeather
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LocationEntity>> getCityLocation(String requestParams) async {
    if (await _networkInfo.isConnected) {
      try {
        return Right(await _remoteDataSource.getCityLocationByName(requestParams));
    } on ServerException {
    return const Left(Failure(errorType: ErrorType.serverError));
    } on NothingToGeocodeException{
        return const Left(Failure(errorType: ErrorType.wrongInformationError));
      } on UnauthorizedException{
    return const Left(Failure(errorType: ErrorType.notAuthorisedError));
    }
    } else {
    return const Left(Failure(errorType: ErrorType.internetConnection));
    }
  }
}
