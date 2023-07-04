import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const throttleDuration = Duration(milliseconds: 1000);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}

Widget getWeatherIcon(String weatherState) {
  switch (weatherState) {
    case 'Clear':
      return SvgPicture.asset('assets/icons/sunny.svg');
    case 'Clouds':
      return SvgPicture.asset('assets/icons/cloudy.svg');
    case 'Rain':
      return SvgPicture.asset('assets/icons/rain.svg');
    default:
      return SvgPicture.asset('assets/icons/default.svg');
  }
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
