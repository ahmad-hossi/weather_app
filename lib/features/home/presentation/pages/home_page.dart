import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/core/extinsions/date_time_extension.dart';
import 'package:weather_app/features/home/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:weather_app/features/home/presentation/pages/city_page.dart';

import '../bloc/city_bloc/city_bloc.dart';
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
    context
        .read<WeatherBloc>()
        .add(GetCurrentWeatherEvent(lon: -37.933, lat: 40.6995));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xE8DDDDE5),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.grey,
            elevation: 0,
            expandedHeight: 180.h,
            toolbarHeight: 70.h,
            pinned: true,
            title: const Text('Aleppo'),
            actions: [
              TextButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CityPage(),));
              }, child: const Icon(Icons.add)),
            ],
            leading:
                TextButton(onPressed: () {}, child: const Icon(Icons.menu)),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Image.network(
                  fit: BoxFit.cover,
                  'https://encrypted-tbn0.gstatic.com/'
                  'images?q=tbn:ANd9GcR3yGg5boZJ-v-oPkZr93mwE_y3Qo1Mm1Tn3w&usqp=CAU'),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.all(8.w),
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CityNameWidget(cityName: 'Damascus'),
                    DateTimeWidget(dateTime: DateTime.now()),
                    SizedBox(
                      height: 8.h,
                    ),
                    const TemperatureWidget(),
                    SizedBox(
                      height: 8.h,
                    ),
                    const HourlyForecastSection()
                  ],
                ),
              )
            ]),
          ),
          SliverToBoxAdapter(
              child: Container(
            margin: EdgeInsets.all(8.w),
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white,
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(vertical: 4.w),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Today'),
                    Row(
                      children: [Icon(Icons.snowing), Text('0%')],
                    ),
                    Row(
                      children: [Icon(Icons.sunny), Icon(Icons.shield_moon)],
                    ),
                    Text('35°/17°'),
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class HourlyForecastSection extends StatelessWidget {
  const HourlyForecastSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => const HourlyForecastWidget(),
      ),
    );
  }
}

class HourlyForecastWidget extends StatelessWidget {
  const HourlyForecastWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.w),
      padding: EdgeInsets.all(2.w),
      child: Column(
        children: [
          const Text('3 PM'),
          SvgPicture.asset(
            'assets/icons/snowy.svg',
            width: 48.w,
            height: 48.w,
          ),
          Text(
            '35°',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal),
          ),
          Row(
            children: [
              SvgPicture.asset('assets/icons/sunny.svg'),
              const Text('0%')
            ],
          )
        ],
      ),
    );
  }
}

class TemperatureWidget extends StatelessWidget {
  const TemperatureWidget({
    super.key,
  });

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
                child: Lottie.asset('assets/animation_files/sunny.json'),
              ),
            ),
            Text(
              '35°',
              style: TextStyle(fontSize: 42.sp, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [Text('Fair'), Text('35°/17°'), Text('Feels like 35°')],
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
