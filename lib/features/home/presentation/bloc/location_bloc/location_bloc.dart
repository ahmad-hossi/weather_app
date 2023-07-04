import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

import '../../../../../core/constants/enum.dart';
import '../../../../../core/services/location_service.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final AppLocation _appLocation;

  LocationBloc(this._appLocation) : super(LocationInitial()) {
    on<GetCurrentLocation>((event, emit) async {
      emit(LocationLoading());
      final eitherResponse = await _appLocation.getCurrentLocation();
      eitherResponse.fold((failure) {
        if (failure == LocationFailureType.serviceLocationNotEnable) {
          return emit(LocationAccessNotEnable());
        } else if (failure == LocationFailureType.denied) {
          return emit(LocationAccessDenied());
        } else {
          return emit(LocationAccessDeniedForever());
        }
      },
          (locationData) =>
              emit(LocationAccessSuccessfully(locationData: locationData)));
    });
  }
}
