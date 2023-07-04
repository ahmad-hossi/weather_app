class Weather {
  final String status;
  final String description;
  final double temp;
  final double tempMin;
  final double tempMax;
  final double feelsLike;
  final double pressure;
  final double humidity;
  final double windSpeed;
  final DateTime dateTime;
  final String cityName;

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
    required this.dateTime,
    required this.cityName,
  });
}
