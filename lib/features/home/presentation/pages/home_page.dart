import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/core/constants/enum.dart';
import 'package:weather_app/core/extinsions/date_time_extension.dart';
import 'package:weather_app/core/extinsions/double_extension.dart';
import 'package:weather_app/core/utils/show_toast.dart';
import 'package:weather_app/features/home/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:app_settings/app_settings.dart';
import '../../../../core/utils/helper_methodes.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/forcast_bloc/forecast_bloc.dart';
import '../bloc/weather_bloc/weather_bloc.dart';

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
      backgroundColor: const Color(0xE8DDDDE5),
      appBar: AppBar(),
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
            }else if(state is WeatherLoaded){
              Navigator.pop(ctx);
            }else if(state is WeatherFailed){
              Navigator.pop(ctx);
              showToastMessage(state.errorMessage);
            }
          }),
          BlocListener<ForecastBloc, ForecastState>(listener: (ctx, state) {
            if (state is ForecastLoading) {
              showLoadingDialog(context);
            }else if(state is ForecastLoaded){
              Navigator.pop(ctx);
            }else if(state is ForecastFailed){
              Navigator.pop(ctx);
              showToastMessage(state.errorMessage);
            }
          }),
        ],
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SliverAppBar(
              //   backgroundColor: Colors.grey,
              //   elevation: 0,
              //   expandedHeight: 180.h,
              //   toolbarHeight: 70.h,
              //   pinned: true,
              //   title: const Text('state.weather.'),
              //   actions: [
              //     TextButton(
              //         onPressed: () {
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => CityPage(),
              //               ));
              //         },
              //         child: const Icon(Icons.search)),
              //   ],
              //   flexibleSpace: FlexibleSpaceBar(
              //     centerTitle: true,
              //     background: Image.network(
              //         fit: BoxFit.cover,
              //         'https://encrypted-tbn0.gstatic.com/'
              //         'images?q=tbn:ANd9GcR3yGg5boZJ-v-oPkZr93mwE_y3Qo1Mm1Tn3w&usqp=CAU'),
              //   ),
              // ),
              BlocBuilder<LocationBloc, LocationState>(
                  builder: (_, locationState) {
                if (locationState is LocationAccessNotEnable ||
                    locationState is LocationAccessDenied) {
                  return Center(
                    child: Container(
                      color: Colors.green,
                      child: TextButton(
                        onPressed: () => context
                            .read<LocationBloc>()
                            .add(GetCurrentLocation()),
                        child: Text('tab to get current weather'),
                      ),
                    ),
                  );
                } else if (locationState is LocationAccessDeniedForever) {
                  return Center(
                    child: Container(
                      color: Colors.red,
                      child: const TextButton(
                        onPressed: AppSettings.openAppSettings,
                        child: Text('enable location permession'),
                      ),
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
                                child: Container(
                                  child: Icon(Icons.refresh),
                                ),
                              )
                            ],
                          ),
                          DateTimeWidget(dateTime: DateTime.now()),
                          SizedBox(
                            height: 8.h,
                          ),
                          TemperatureWidget(
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
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 4.w),
                            child: WeatherDayCardWidget(
                              dayName: state.forecast[0].dateTime.dayName,
                              dayState: state.forecast[0].status,
                              nightState: state.forecast[4].status,
                              dayTemp: state.forecast[0].temp,
                              nightTemp: state.forecast[4].temp,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 4.w),
                            child: WeatherDayCardWidget(
                              dayName: state.forecast[4].dateTime.dayName,
                              dayState: state.forecast[8].status,
                              nightState: state.forecast[4].status,
                              dayTemp: state.forecast[8].temp,
                              nightTemp: state.forecast[4].temp,
                            ),
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
          ),
        ),
      ),
    );
  }

}

class WeatherHumidityWidget extends StatelessWidget {
  const WeatherHumidityWidget({
    required this.humidity,
    super.key,
  });

  final double humidity;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SvgPicture.asset(
        'assets/icons/wind.svg',
        width: 28,
        height: 28,
      ),
      SizedBox(
        width: 8.w,
      ),
      const Text('Humidity'),
      const Spacer(),
      Text('${humidity} %'),
    ]);
  }
}

class WeatherWindWidget extends StatelessWidget {
  const WeatherWindWidget({
    required this.windSpeed,
    super.key,
  });

  final double windSpeed;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SvgPicture.asset(
        'assets/icons/wind.svg',
        width: 28,
        height: 28,
      ),
      SizedBox(
        width: 8.w,
      ),
      const Text('Wind'),
      const Spacer(),
      Text('$windSpeed km/h'),
    ]);
  }
}

class WeatherDayCardWidget extends StatelessWidget {
  const WeatherDayCardWidget({
    super.key,
    required this.dayName,
    required this.dayState,
    required this.nightState,
    required this.dayTemp,
    required this.nightTemp,
  });

  final String dayName;
  final String dayState;
  final String nightState;
  final double dayTemp;
  final double nightTemp;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(dayName)),
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                getWeatherIcon(dayState, IconType.day),
                getWeatherIcon(nightState, IconType.night),
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: Text('${dayTemp.toCelsius}/${nightTemp.toCelsius}')),
        ],
      ),
    );
  }
}

// class HourlyForecastSection extends StatelessWidget {
//   const HourlyForecastSection({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 150.h,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) => const HourlyForecastWidget(),
//       ),
//     );
//   }
// }
//
// class HourlyForecastWidget extends StatelessWidget {
//   const HourlyForecastWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(2.w),
//       padding: EdgeInsets.all(2.w),
//       child: Column(
//         children: [
//           const Text('3 PM'),
//           SvgPicture.asset(
//             'assets/icons/snowy.svg',
//             width: 48.w,
//             height: 48.w,
//           ),
//           Text(
//             '35°',
//             style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal),
//           ),
//           Row(
//             children: [
//               SvgPicture.asset('assets/icons/sunny.svg'),
//               const Text('0%')
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

class TemperatureWidget extends StatelessWidget {
  const TemperatureWidget({
    required this.description,
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.feelTemp,
    super.key,
  });

  final String description;
  final double temp;
  final double minTemp;
  final double maxTemp;
  final double feelTemp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 50.w,
              height: 50.w,
              child: Center(
                child: getWeatherIcon('Clear', IconType.day, static: false),
              ),
            ),
            Text(
              temp.toCelsius,
              style: TextStyle(fontSize: 42.sp, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(description),
            Text('${minTemp.toCelsius}/${maxTemp.toCelsius}'),
            Text('Feels like ${feelTemp.toCelsius}')
          ],
        )
      ],
    );
  }
}

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({
    required this.dateTime,
    super.key,
  });

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Text(
      dateTime.prettyFormat(),
      style: const TextStyle(color: Colors.grey),
    );
  }
}

class CityNameWidget extends StatelessWidget {
  final String cityName;

  const CityNameWidget({
    required this.cityName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.w),
      child: Text(
        cityName,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
