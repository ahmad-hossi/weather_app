import 'package:flutter/material.dart';
import 'package:weather_app/core/extinsions/date_time_extension.dart';


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