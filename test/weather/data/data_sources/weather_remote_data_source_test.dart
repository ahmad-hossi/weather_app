import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/constants/app_constant.dart';
import 'package:weather_app/core/entities/get_weather_params.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/home/data/data_sources/weather_remote_date_source.dart';
import 'package:weather_app/features/home/data/models/weather_model.dart';

import '../../../fixtures/fixture_reader.dart';
import 'weather_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late WeatherRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = WeatherRemoteDataSourceImpl(mockHttpClient);
  });

  group('getCurrentWeather', () {
    final tRequestParams =
        GetWeatherParams(lon: 37.7749, lat: -122.4194).toRequestParams();
    final tWeatherModel =
        WeatherModel.fromJson(json.decode(fixture('weather.json')));

    test(
      'should perform a GET request on the get current '
      'weather end point with correct headers',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
            (_) async => http.Response(fixture('weather.json'), 200));
        // act
        await dataSource.getCurrentWeather(tRequestParams);
        // assert
        verify(
          mockHttpClient.get(
            Uri.parse(
              '${AppConstants.baseUrl}/${AppConstants.currentWeatherEndPoint}$tRequestParams',
            ),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          ),
        );
      },
    );

    test(
      'should return WeatherModel when the response code is 200 (success)',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
            (_) async => http.Response(fixture('weather.json'), 200));
        // act
        final result = await dataSource.getCurrentWeather(tRequestParams);
        // assert
        expect(true, result.toString() == tWeatherModel.toString());
      },
    );


    test(
      'should throw ServerException for other response codes',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('{"key": "value"}', 500));
        // act
        final call = dataSource.getCurrentWeather(tRequestParams);
        // assert
        expect(call, throwsA(isInstanceOf<ServerException>()));
      },
    );
  });
}
