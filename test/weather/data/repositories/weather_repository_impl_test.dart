import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/entities/get_weather_params.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/home/data/data_sources/weather_remote_date_source.dart';
import 'package:weather_app/features/home/data/models/weather_model.dart';
import 'package:weather_app/features/home/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/home/domain/entities/weather.dart';

import 'weather_repository_impl_test.mocks.dart';

@GenerateMocks([NetworkInfo, WeatherRemoteDataSource])
void main() {
  late WeatherRepositoryImpl repository;
  late MockNetworkInfo mockNetworkInfo;
  late MockWeatherRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockWeatherRemoteDataSource();
    repository = WeatherRepositoryImpl(mockNetworkInfo, mockRemoteDataSource);
  });

  final testParams = GetWeatherParams(lon: -73.933783, lat: 40.659569);
  final testWeatherModel = WeatherModel(
    status: 'Rain',
    description: 'light rain',
    temp: 296.51,
    tempMin: 296.51,
    tempMax: 297.04,
    feelsLike: 297.2,
    pressure: 1009,
    humidity: 88,
    windSpeed: 3.98,
    dateTime: DateTime.now(),
    cityName: 'Aleppo',
  );
  final Weather testWeather = testWeatherModel;
  final testWeatherModelList = [
    WeatherModel(
      status: 'Rain',
      description: 'light rain',
      temp: 296.51,
      tempMin: 296.51,
      tempMax: 297.04,
      feelsLike: 297.2,
      pressure: 1009,
      humidity: 88,
      windSpeed: 3.98,
      dateTime: DateTime.now(),
      cityName: 'Aleppo',
    )
  ];
  final List<Weather> testWeatherList = testWeatherModelList;

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  group('get current weather', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        final result = await mockNetworkInfo.isConnected;
        // assert
        verify(mockNetworkInfo.isConnected);
        expect(result, true);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getCurrentWeather(any))
              .thenAnswer((_) async => testWeatherModel);
          // act
          final result =
              await repository.getCurrentWeather(testParams.toRequestParams());
          // assert
          verify(mockRemoteDataSource
              .getCurrentWeather(testParams.toRequestParams()));
          expect(result, equals(Right(testWeather)));
        },
      );

      test(
          'should return server error when the server throws a ServerException',
          () async {
        // Arrange
        when(mockRemoteDataSource
                .getCurrentWeather(testParams.toRequestParams()))
            .thenThrow(ServerException());

        // Act
        final result =
            await repository.getCurrentWeather(testParams.toRequestParams());

        // Assert
        expect(result, const Left(Failure(errorType: ErrorType.serverError)));
        verify(mockRemoteDataSource
            .getCurrentWeather(testParams.toRequestParams()));
        verifyNoMoreInteractions(mockRemoteDataSource);
      });

      test(
          'should return not authorized error when the server returns 401 status code',
          () async {
        // Arrange
        when(mockRemoteDataSource
                .getCurrentWeather(testParams.toRequestParams()))
            .thenThrow(UnauthorizedException());

        // Act
        final result =
            await repository.getCurrentWeather(testParams.toRequestParams());

        // Assert
        expect(result,
            const Left(Failure(errorType: ErrorType.notAuthorisedError)));
        verify(mockRemoteDataSource
            .getCurrentWeather(testParams.toRequestParams()));
        verifyNoMoreInteractions(mockRemoteDataSource);
      });
    });
  });

  group('get 5 days weather weather', () {
    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource
                  .get5DaysWeather(testParams.toRequestParams()))
              .thenAnswer((_) async => testWeatherModelList);
          // act
          final result =
              await repository.get5DaysWeather(testParams.toRequestParams());
          // assert
          verify(mockRemoteDataSource
              .get5DaysWeather(testParams.toRequestParams()));
          expect(result, equals(Right(testWeatherList)));
        },
      );

      test(
          'should return server error when the server throws a ServerException',
          () async {
        // Arrange
        when(mockRemoteDataSource.get5DaysWeather(testParams.toRequestParams()))
            .thenThrow(ServerException());

        // Act
        final result =
            await repository.get5DaysWeather(testParams.toRequestParams());

        // Assert
        expect(result, const Left(Failure(errorType: ErrorType.serverError)));
        verify(
            mockRemoteDataSource.get5DaysWeather(testParams.toRequestParams()));
        verifyNoMoreInteractions(mockRemoteDataSource);
      });

      test(
          'should return not authorized error when the server returns 401 status code',
          () async {
        // Arrange
        when(mockRemoteDataSource.get5DaysWeather(testParams.toRequestParams()))
            .thenThrow(UnauthorizedException());

        // Act
        final result =
            await repository.get5DaysWeather(testParams.toRequestParams());

        // Assert
        expect(result,
            const Left(Failure(errorType: ErrorType.notAuthorisedError)));
        verify(
            mockRemoteDataSource.get5DaysWeather(testParams.toRequestParams()));
        verifyNoMoreInteractions(mockRemoteDataSource);
      });
    });
  });
}
