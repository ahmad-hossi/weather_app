import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/extinsions/double_extension.dart';

import '../../../../core/constants/enum.dart';
import '../../../../core/utils/helper_methodes.dart';


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