extension DoubleExtensions on double {
  String get toCelsius => '${(this - 273.15).floor()}°';
}
