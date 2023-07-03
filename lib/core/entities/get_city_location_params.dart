import 'package:weather_app/core/constants/app_constant.dart';

class GetCityLocationParams {
  String cityName;

  GetCityLocationParams({
    required this.cityName
  });

  String toRequestParams() => 'q=$cityName&appid=${AppConstants.apiKey}';
}
