import 'package:flutter/material.dart';

void printC(String message, [Color? foregroundColor, Color? backgroundColor]) {
  const String startCode = '\x1B[';
  const String endCode = 'm';

  final int foregroundColorCode = _getAnsiColorCode(foregroundColor, 30);
  final int backgroundColorCode = _getAnsiColorCode(backgroundColor, 40);

  final String colorCode = '${startCode}${foregroundColorCode};${backgroundColorCode}';

  final String coloredMessage = '$colorCode$endCode$message$endCode';
  print(coloredMessage);
}

int _getAnsiColorCode(Color? color, int baseColorCode) {
  if (color == null) return baseColorCode;

  final List<int> availableColorCodes = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  final List<Color> availableColors = [
    Colors.black,
    Colors.red,
    Colors.green,
    Colors.amber,
    Colors.blue,
    Colors.purple,
    Colors.cyan,
    Colors.white,
  ];

  final int colorIndex = availableColors.indexOf(color);
  if (colorIndex == -1) return baseColorCode;

  final int colorCode = availableColorCodes[colorIndex];
  return baseColorCode + colorCode;
}
