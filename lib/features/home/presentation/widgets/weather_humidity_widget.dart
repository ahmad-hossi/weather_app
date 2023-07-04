import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
        'assets/icons/humidity.svg',
        width: 28,
        height: 28,
      ),
      SizedBox(
        width: 8.w,
      ),
      const Text('Humidity'),
      const Spacer(),
      Text('$humidity %'),
    ]);
  }
}