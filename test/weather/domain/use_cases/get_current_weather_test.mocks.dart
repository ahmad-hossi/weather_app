// Mocks generated by Mockito 5.4.2 from annotations
// in weather_app/test/weather/domain/use_cases/get_current_weather_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:weather_app/core/error/failures.dart' as _i5;
import 'package:weather_app/features/home/domain/entities/weather.dart' as _i6;
import 'package:weather_app/features/home/domain/repositories/weather_repository.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WeatherRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherRepository extends _i1.Mock implements _i3.WeatherRepository {
  MockWeatherRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Weather>> getCurrentWeather(
          String? requestParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentWeather,
          [requestParams],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Weather>>.value(
            _FakeEither_0<_i5.Failure, _i6.Weather>(
          this,
          Invocation.method(
            #getCurrentWeather,
            [requestParams],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Weather>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Weather>>> get5DaysWeather(
          String? requestParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #get5DaysWeather,
          [requestParams],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i6.Weather>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.Weather>>(
          this,
          Invocation.method(
            #get5DaysWeather,
            [requestParams],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Weather>>>);
}
