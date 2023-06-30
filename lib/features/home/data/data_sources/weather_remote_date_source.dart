import 'dart:convert';
import '../../../../core/constants/app_constant.dart';
import '../../../../core/error/exceptions.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String requestParams);
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
}
