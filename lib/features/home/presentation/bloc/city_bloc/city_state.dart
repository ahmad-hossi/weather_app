part of 'city_bloc.dart';


abstract class CityState {}

class CityInitial extends CityState {}
class CityLoading extends CityState {}
class CityLocationDeterminedSuccessfully extends CityState {
  LocationEntity cityData;

  CityLocationDeterminedSuccessfully({required this.cityData});
}
class CityLocationDetermineFailed extends CityState {
  final String errorMessage;

  CityLocationDetermineFailed({
    required this.errorMessage,
  });
}
