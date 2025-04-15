import 'package:flutter/material.dart';

class Dimensions {
  static late double screenHeight;
  static late double screenWidth;

  static late double pagePadding;
  static late double fontSmall;
  static late double fontMedium;
  static late double fontLarge;

  static late double radiusSmall;
  static late double radiusMedium;
  static late double radiusLarge;

  static late double buttonHeight;
  static late double textFieldHeight;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    pagePadding = screenWidth * 0.06;

    fontSmall = screenHeight * 0.016; // ~12
    fontMedium = screenHeight * 0.02; // ~14
    fontLarge = screenHeight * 0.04; // ~32

    radiusSmall = screenWidth * 0.02;
    radiusMedium = screenWidth * 0.03;
    radiusLarge = screenWidth * 0.05;

    buttonHeight = screenHeight * 0.07;
    textFieldHeight = screenHeight * 0.065;
  }
}
