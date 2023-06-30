part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationAccessDenied extends LocationState {}

class LocationAccessDeniedForever extends LocationState {}

class LocationAccessSuccessfully extends LocationState {
  final LocationData locationData;
  LocationAccessSuccessfully({
    required this.locationData,
  });
}

class LocationAccessNotEnable extends LocationState {}
