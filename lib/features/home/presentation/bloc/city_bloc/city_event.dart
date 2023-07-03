part of 'city_bloc.dart';

abstract class CityEvent {}

class GetCityLocationEvent extends CityEvent {
  String cityName;
  GetCityLocationEvent({required this.cityName});
}
