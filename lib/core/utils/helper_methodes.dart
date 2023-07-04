import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              ? 'assets/icons/sunny.svg'
              : 'assets/icons/cloudy.svg'
          : type == IconType.night
              ? 'assets/animation_files/sunny.json'
              : 'assets/animation_files/sunny.json';
    case 'Clouds':
    case 'Rain':
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
