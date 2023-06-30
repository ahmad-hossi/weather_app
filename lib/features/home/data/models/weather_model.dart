class WeatherModel {
  String status;
  String description;
  double temp;
  double tempMin;
  double tempMax;
  double feelsLike;
  double pressure;
  double humidity;
  double windSpeed;

  WeatherModel({
    required this.status,
    required this.description,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        status: json['weather'][0]['main'],
        description: json['weather'][0]['description'],
        temp: (json['main']['temp'] as num).toDouble(),
        tempMin: (json['main']['temp_min'] as num).toDouble(),
        tempMax: (json['main']['temp_max'] as num).toDouble(),
        feelsLike: (json['main']['feels_like'] as num).toDouble(),
        pressure: (json['main']['pressure'] as num).toDouble(),
        humidity: (json['main']['humidity'] as num).toDouble(),
        windSpeed: (json['wind']['speed'] as num).toDouble(),
      );
}
