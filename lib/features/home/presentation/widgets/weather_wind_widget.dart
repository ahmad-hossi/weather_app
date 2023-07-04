import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';


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