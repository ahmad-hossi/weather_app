import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/show_toast.dart';
import 'package:weather_app/features/home/domain/use_cases/get_5days_weather.dart';
import 'package:weather_app/features/home/presentation/bloc/city_bloc/city_bloc.dart';
import 'package:weather_app/features/home/presentation/bloc/forcast_bloc/forecast_bloc.dart';
import 'package:weather_app/features/home/presentation/bloc/weather_bloc/weather_bloc.dart';

import '../../domain/entities/location_entity.dart';

class CityPage extends StatelessWidget {
  const CityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  context
                      .read<CityBloc>()
                      .add(GetCityLocationEvent(cityName: value));
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  filled: true,
                  fillColor: const Color(0xFFE6E6E6),
                  prefixIcon: const Padding(
                      padding: EdgeInsets.all(4), child: Icon(Icons.search)),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFE6E6E6)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Expanded(
                  child: BlocConsumer<CityBloc, CityState>(
                listener: (_, state) {
                  if (state is CityLocationDetermineFailed) {
                    showToastMessage(state.errorMessage);
                  }
                },
                builder: (context, state) {
                  if (state is CityInitial) {
                    return const Center(child: Text('Enter a city name'));
                  } else if (state is CityLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CityLocationDeterminedSuccessfully) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: SearchResult(cityData: state.cityData),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  const SearchResult({super.key, required this.cityData});
  final LocationEntity cityData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<WeatherBloc>()
            .add(GetCurrentWeatherEvent(lon: cityData.lon, lat: cityData.lat));
        context.read<ForecastBloc>().add(GetWeatherForecast(
              lat: cityData.lat,
              lon: cityData.lon,
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cityData.cityName,
            style: const TextStyle(fontSize: 24),
          ),
          Text(
            '${cityData.state ?? ''} , ${cityData.country}',
            style: const TextStyle(color: Colors.grey),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          )
        ],
      ),
    );
  }
}
