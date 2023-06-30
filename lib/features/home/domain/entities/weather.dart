class Weather {
  String status;
  String description;
  double temp;
  double tempMin;
  double tempMax;
  double feelsLike;
  double pressure;
  double humidity;
  double windSpeed;

  Weather({
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
}
