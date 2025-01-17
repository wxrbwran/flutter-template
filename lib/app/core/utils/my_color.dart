import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Color MyColor(String colorString, {double alpha = 1.0}) {
  String colorStr = colorString;
  // colorString未带0xff前缀并且长度为6
  if (!colorStr.startsWith('0xff') && colorStr.length == 6) {
    colorStr = '0xff' + colorStr;
  }
  // colorString为8位，如0x000000
  if (colorStr.startsWith('0x') && colorStr.length == 8) {
    colorStr = colorStr.replaceRange(0, 2, '0xff');
  }
  // colorString为7位，如#000000
  if (colorStr.startsWith('#') && colorStr.length == 7) {
    colorStr = colorStr.replaceRange(0, 1, '0xff');
  }
  // 先分别获取色值的RGB通道
  Color color = Color(int.parse(colorStr));
  int red = color.red;
  int green = color.green;
  int blue = color.blue;
  // 通过fromRGBO返回带透明度和RGB值的颜色
  return Color.fromRGBO(red, green, blue, alpha);
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
