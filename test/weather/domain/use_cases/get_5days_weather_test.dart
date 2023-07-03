import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/entities/get_weather_params.dart';
import 'package:weather_app/features/home/domain/entities/weather.dart';
import 'package:weather_app/features/home/domain/use_cases/get_5days_weather.dart';
import 'get_current_weather_test.mocks.dart';

void main() {
  late Get5DaysWeather useCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    useCase = Get5DaysWeather(mockWeatherRepository);
  });

  final testParams = GetWeatherParams(lon: -73.933783, lat: 40.659569);
  final testWeatherList = [
    Weather(
      status: 'Rain',
      description: "light rain",
      temp: 296.51,
      tempMin: 296.51,
      tempMax: 297.04,
      feelsLike: 297.2,
      pressure: 1009,
      humidity: 88,
      windSpeed: 3.98,
    ),
    Weather(
      status: 'Clear',
      description: "clear sky",
      temp: 301.33,
      tempMin: 300.82,
      tempMax: 303.55,
      feelsLike: 302.41,
      pressure: 1008,
      humidity: 67,
      windSpeed: 2.36,
    ),
  ];

  test('should get current weather for specific location from the repository',
          () async {
        //Arrange
        when(mockWeatherRepository.get5DaysWeather(testParams.toRequestParams()))
            .thenAnswer((_) async => Right(testWeatherList));

        // Act
        final result = await useCase(testParams);

        //Assert
        expect(result, Right(testWeatherList));
        verify(
            mockWeatherRepository.get5DaysWeather(testParams.toRequestParams()));
        verifyNoMoreInteractions(mockWeatherRepository);
      });
}
