import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/home/data/models/weather_model.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  test('WeatherModel should be created from valid JSON data', () {
    final weatherModel =
        WeatherModel.fromJson(json.decode(fixture('weather.json')));

    expect(weatherModel.status, equals('Rain'));
    expect(weatherModel.description, equals('light rain'));
    expect(weatherModel.temp, equals(296.51));
    expect(weatherModel.tempMin, equals(296.51));
    expect(weatherModel.tempMax, equals(297.04));
    expect(weatherModel.feelsLike, equals(297.2));
    expect(weatherModel.pressure, equals(1009));
    expect(weatherModel.humidity, equals(88));
    expect(weatherModel.windSpeed, equals(3.98));
  });
}
