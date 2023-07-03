import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/home/presentation/bloc/city_bloc/city_bloc.dart';

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
              Expanded(child: BlocBuilder<CityBloc, CityState>(
                builder: (context, state) {
                  if (state is CityInitial) {
                    return const Center(child: Text('Enter a Location name'));
                  } else if (state is CityLoading) {
                    return const Center(child: Text('Loading'));
                  } else if (state is CityLocationDeterminedSuccessfully) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: SearchResult(
                          cityName: state.cityLocation.cityName,
                          state: state.cityLocation.state,
                          country: state.cityLocation.country),
                    );

                    Center(
                        child: Text(
                            '${state.cityLocation.cityName},${state.cityLocation.country}'));
                  } else {
                    return const Center(child: Text('Failed'));
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
  const SearchResult({
    super.key,
    required this.cityName,
    required this.country,
    required this.state,
  });
  final String cityName;
  final String country;
  final String state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cityName,
            style: const TextStyle(fontSize: 24),
          ),
          Text(
            '$state , $country',
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
