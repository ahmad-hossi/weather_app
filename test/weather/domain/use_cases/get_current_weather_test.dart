import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/entities/get_weather_params.dart';
import 'package:weather_app/features/home/domain/entities/weather.dart';
import 'package:weather_app/features/home/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/home/domain/use_cases/get_current_weather.dart';

import 'get_current_weather_test.mocks.dart';

@GenerateMocks([WeatherRepository])

void main() {
  late GetCurrentWeather useCase;
    late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    useCase = GetCurrentWeather(mockWeatherRepository);
  });

  final testParams = GetWeatherParams(lon: -73.933783, lat: 40.659569);
  final testWeather = Weather(
      status: 'Rain',
      description: "light rain",
      temp: 296.51,
      tempMin: 296.51,
      tempMax: 297.04,
      feelsLike: 297.2,
      pressure: 1009,
      humidity: 88,
      windSpeed: 3.98);

  test('should get current weather for specific location from the repository',
      () async {
    //Arrange
    when(mockWeatherRepository.getCurrentWeather(testParams.toRequestParams()))
        .thenAnswer((_) async => Right(testWeather));

    // Act
    final result = await useCase(testParams);

    //Assert
    expect(result, Right(testWeather));
    verify(
        mockWeatherRepository.getCurrentWeather(testParams.toRequestParams()));
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
