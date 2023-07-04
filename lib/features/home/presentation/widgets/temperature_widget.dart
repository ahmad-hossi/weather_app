import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/extinsions/double_extension.dart';

import '../../../../core/constants/enum.dart';
import '../../../../core/utils/helper_methodes.dart';


class TemperatureWidget extends StatelessWidget {
  const TemperatureWidget({
    required this.state,
    required this.description,
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.feelTemp,
    super.key,
  });

  final String description;
  final String state;
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
                child: getWeatherIcon(
                    state,
                    DateTime.now().hour < 18 && DateTime.now().hour > 4
                        ? IconType.day
                        : IconType.night,
                    static: false),
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