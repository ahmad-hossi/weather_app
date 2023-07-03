part of 'city_bloc.dart';


abstract class CityState {}

class CityInitial extends CityState {}
class CityLoading extends CityState {}
class CityLocationDeterminedSuccessfully extends CityState {
  LocationEntity cityLocation;

  CityLocationDeterminedSuccessfully({required this.cityLocation});
}
class CityLocationDetermineFailed extends CityState {}
