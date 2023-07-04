import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/extinsions/date_time_extension.dart';
import 'package:weather_app/core/utils/show_toast.dart';
import 'package:weather_app/features/home/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:app_settings/app_settings.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/forcast_bloc/forecast_bloc.dart';
import '../bloc/weather_bloc/weather_bloc.dart';
import '../widgets/city_name_widget.dart';
import '../widgets/date_time_widget.dart';
import '../widgets/temperature_widget.dart';
import '../widgets/warning_widget.dart';
import '../widgets/weather_day_card_widget.dart';
import '../widgets/weather_humidity_widget.dart';
import '../widgets/weather_wind_widget.dart';
import 'city_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<LocationBloc>().add(GetCurrentLocation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xE8ECECF3),
      body: MultiBlocListener(
        listeners: [
          BlocListener<LocationBloc, LocationState>(listener: (_, state) {
            if (state is LocationAccessSuccessfully) {
              context.read<WeatherBloc>().add(GetCurrentWeatherEvent(
                  lon: double.parse(state.locationData.longitude.toString()),
                  lat: double.parse(state.locationData.latitude.toString())));
              context.read<ForecastBloc>().add(GetWeatherForecast(
                  lon: double.parse(state.locationData.longitude.toString()),
                  lat: double.parse(state.locationData.latitude.toString())));
            }
          }),
          BlocListener<WeatherBloc, WeatherState>(listener: (ctx, state) {
            if (state is WeatherLoading) {
              showLoadingDialog(context);
            } else if (state is WeatherLoaded) {
              Navigator.pop(ctx);
            } else if (state is WeatherFailed) {
              Navigator.pop(ctx);
              showToastMessage(state.errorMessage);
            }
          }),
          BlocListener<ForecastBloc, ForecastState>(listener: (ctx, state) {
            if (state is ForecastFailed) {
              showToastMessage(state.errorMessage);
            }
          }),
        ],
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.lightBlueAccent,
              elevation: 0,
              toolbarHeight: 70.h,
              pinned: true,
              title: const Text('Weather App'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CityPage(),
                          ));
                    },
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ],
            ),
            SliverList(
                delegate: SliverChildListDelegate(
              [
                BlocBuilder<LocationBloc, LocationState>(
                    builder: (_, locationState) {
                  if (locationState is LocationAccessNotEnable ||
                      locationState is LocationAccessDenied) {
                    return Center(
                      child: InkWell(
                        onTap: () {
                          context
                              .read<LocationBloc>()
                              .add(GetCurrentLocation());
                        },
                        child: const WarningWidget(),
                      ),
                    );
                  } else if (locationState is LocationAccessDeniedForever) {
                    return  Center(
                      child: InkWell(
                        onTap: (){
                          AppSettings.openAppSettings();
                        },
                        child: const WarningWidget(),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                BlocBuilder<WeatherBloc, WeatherState>(
                  buildWhen: (prev, curr) => curr is WeatherLoaded,
                  builder: (context, weatherState) {
                    if (weatherState is WeatherLoaded) {
                      return Container(
                        margin: EdgeInsets.all(8.w),
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CityNameWidget(
                                    cityName: weatherState.weather.cityName),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<WeatherBloc>()
                                        .add(GetCurrentWeatherEvent());
                                  },
                                  child: const Icon(Icons.refresh),
                                )
                              ],
                            ),
                            DateTimeWidget(dateTime: DateTime.now()),
                            SizedBox(
                              height: 8.h,
                            ),
                            TemperatureWidget(
                              state: weatherState.weather.status,
                              description: weatherState.weather.description,
                              temp: weatherState.weather.temp,
                              feelTemp: weatherState.weather.feelsLike,
                              minTemp: weatherState.weather.tempMin,
                              maxTemp: weatherState.weather.tempMax,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            WeatherWindWidget(
                                windSpeed: weatherState.weather.windSpeed),
                            const Divider(),
                            WeatherHumidityWidget(
                              humidity: weatherState.weather.humidity,
                            )
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: SizedBox.shrink());
                    }
                  },
                ),
                BlocBuilder<ForecastBloc, ForecastState>(
                  buildWhen: (prev, curr) => curr is ForecastLoaded,
                  builder: (context, state) {
                    if (state is ForecastLoaded) {
                      return Container(
                        margin: EdgeInsets.all(8.w),
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white,
                        ),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            WeatherDayCardWidget(
                              dayName: state.forecast[0].dateTime.dayName,
                              dayState: state.forecast[0].status,
                              nightState: state.forecast[4].status,
                              dayTemp: state.forecast[0].temp,
                              nightTemp: state.forecast[4].temp,
                            ),
                            WeatherDayCardWidget(
                              dayName: state.forecast[4].dateTime.dayName,
                              dayState: state.forecast[8].status,
                              nightState: state.forecast[4].status,
                              dayTemp: state.forecast[8].temp,
                              nightTemp: state.forecast[4].temp,
                            ),
                            WeatherDayCardWidget(
                              dayName: state.forecast[12].dateTime.dayName,
                              dayState: state.forecast[16].status,
                              nightState: state.forecast[12].status,
                              dayTemp: state.forecast[16].temp,
                              nightTemp: state.forecast[12].temp,
                            ),
                            WeatherDayCardWidget(
                              dayName: state.forecast[20].dateTime.dayName,
                              dayState: state.forecast[24].status,
                              nightState: state.forecast[20].status,
                              dayTemp: state.forecast[24].temp,
                              nightTemp: state.forecast[20].temp,
                            ),
                            WeatherDayCardWidget(
                              dayName: state.forecast[28].dateTime.dayName,
                              dayState: state.forecast[32].status,
                              nightState: state.forecast[28].status,
                              dayTemp: state.forecast[32].temp,
                              nightTemp: state.forecast[28].temp,
                            ),
                            WeatherDayCardWidget(
                              dayName: state.forecast[36].dateTime.dayName,
                              dayState: state.forecast[39].status,
                              nightState: state.forecast[36].status,
                              dayTemp: state.forecast[39].temp,
                              nightTemp: state.forecast[36].temp,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}



