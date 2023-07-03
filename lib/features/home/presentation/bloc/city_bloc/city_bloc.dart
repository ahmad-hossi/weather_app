import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/core/entities/get_city_location_params.dart';

import '../../../../../core/utils/helper_methodes.dart';
import '../../../domain/entities/location_entity.dart';
import '../../../domain/use_cases/get_city_location.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final GetCityLocation getCityLocation;
  CityBloc(this.getCityLocation) : super(CityInitial()) {
    on<GetCityLocationEvent>(_onGetCityLocationEvent,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onGetCityLocationEvent(
      GetCityLocationEvent event, Emitter<CityState> emit) async {
    emit(CityLoading());
    final eitherResponse =
        await getCityLocation(GetCityLocationParams(cityName: event.cityName));
    print(eitherResponse);
    emit(eitherResponse.fold(
        (failure) => CityLocationDetermineFailed(),
        (location) =>
            CityLocationDeterminedSuccessfully(cityLocation: location)));
  }
}
