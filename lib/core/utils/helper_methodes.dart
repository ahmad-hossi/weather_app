import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/app_icons.dart';

import '../constants/enum.dart';

const throttleDuration = Duration(milliseconds: 1000);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}

Widget getWeatherIcon(String weatherState, IconType type,
    {bool static = true}) {
  String iconPath = '';
  switch (weatherState) {
    case 'Clear':
      iconPath = static
          ? type == IconType.day
              ? AppIcons.sunny
              : AppIcons.clearNight
          : type == IconType.day
              ? AppIcons.sunnyAnimated
              : AppIcons.clearNightAnimated;
    case 'Clouds':
      iconPath = static
          ? type == IconType.day
          ? AppIcons.cloudy
          : AppIcons.cloudy
          : type == IconType.day
          ? AppIcons.cloudyDayAnimated
          : AppIcons.cloudyNightAnimated;
    case 'Rain':
      iconPath = static
          ? type == IconType.day
          ? AppIcons.rainy
          : AppIcons.rainy
          : type == IconType.day
          ? AppIcons.rainyDayAnimated
          : AppIcons.rainyNightAnimated;
    case 'Snow':
      iconPath = static
          ? type == IconType.day
          ? AppIcons.snowy
          : AppIcons.snowy
          : type == IconType.day
          ? AppIcons.snowyDayAnimated
          : AppIcons.snowyNightAnimated;
    default:
  }
  return static ? SvgPicture.asset(iconPath) : Lottie.asset(iconPath);
}

String getDayName(DateTime dateTime) {
  DateTime now = DateTime.now();
  if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day) {
    return 'Today';
  }

  final List<String> dayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  return dayNames[dateTime.weekday];
}
