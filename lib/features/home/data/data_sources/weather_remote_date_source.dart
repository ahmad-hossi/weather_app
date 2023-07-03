import 'dart:convert';
import '../../../../core/constants/app_constant.dart';
import '../../../../core/error/exceptions.dart';
import '../models/location_model.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;


abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String requestParams);
  Future<List<WeatherModel>> get5DaysWeather(String requestParams);
  Future<LocationModel> getCityLocationByName(String requestParams);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client _client;
  WeatherRemoteDataSourceImpl(this._client);

  @override
  Future<WeatherModel> getCurrentWeather(String requestParams) async {
    try {
      final response = await _client.get(
        Uri.parse(
            '${AppConstants.baseUrl}/${AppConstants.currentWeatherEndPoint}'
            '$requestParams'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return WeatherModel.fromJson(responseData);
      } else if (response.statusCode == 400) {
        throw WrongLonOrLatException();
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<LocationModel> getCityLocationByName(String requestParams) async {
    try {
      final response = await _client.get(
        Uri.parse(
            '${AppConstants.baseUrl}/${AppConstants.getCityLocationByName}'
                '$requestParams'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return LocationModel.fromJson(responseData[0]);
      } else if (response.statusCode == 400){
        throw NothingToGeocodeException();
      }
      else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<WeatherModel>> get5DaysWeather(String requestParams) async {
    try {
      final response = await _client.get(
        Uri.parse(
            '${AppConstants.baseUrl}/${AppConstants.fiveDaysWeatherEndPoint}'
            '$requestParams'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return (responseData['list'] as List<dynamic>)
            .map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 400) {
        throw WrongLonOrLatException();
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
