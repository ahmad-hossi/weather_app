import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/features/home/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:weather_app/features/home/presentation/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/features/home/presentation/pages/home_page.dart';
import 'injection_container.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (BuildContext context, Widget? child) => MultiBlocProvider(
        providers: [
          BlocProvider<LocationBloc>(create: (_) => sl<LocationBloc>()),
          BlocProvider<WeatherBloc>(create: (_) => sl<WeatherBloc>()),
        ],
        child: MaterialApp(home: child),
      ),
      child: HomePage(),
    );
  }
}
