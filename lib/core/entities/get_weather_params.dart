import 'package:weather_app/core/constants/app_constant.dart';

class GetWeatherParams {
  double lon;
  double lat;

  GetWeatherParams({
    required this.lon,
    required this.lat,
  });

  String toRequestParams() => 'lat=$lat&lon=$lon&appid=${AppConstants.apiKey}';
}
