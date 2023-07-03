// Mocks generated by Mockito 5.4.2 from annotations
// in weather_app/test/weather/data/repositories/weather_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:weather_app/core/network/network_info.dart' as _i3;
import 'package:weather_app/features/home/data/data_sources/weather_remote_date_source.dart'
    as _i5;
import 'package:weather_app/features/home/data/models/weather_model.dart'
    as _i2;

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

class _FakeWeatherModel_0 extends _i1.SmartFake implements _i2.WeatherModel {
  _FakeWeatherModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i3.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}

/// A class which mocks [WeatherRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherRemoteDataSource extends _i1.Mock
    implements _i5.WeatherRemoteDataSource {
  MockWeatherRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.WeatherModel> getCurrentWeather(String? requestParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentWeather,
          [requestParams],
        ),
        returnValue: _i4.Future<_i2.WeatherModel>.value(_FakeWeatherModel_0(
          this,
          Invocation.method(
            #getCurrentWeather,
            [requestParams],
          ),
        )),
      ) as _i4.Future<_i2.WeatherModel>);
  @override
  _i4.Future<List<_i2.WeatherModel>> get5DaysWeather(String? requestParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #get5DaysWeather,
          [requestParams],
        ),
        returnValue:
            _i4.Future<List<_i2.WeatherModel>>.value(<_i2.WeatherModel>[]),
      ) as _i4.Future<List<_i2.WeatherModel>>);
}