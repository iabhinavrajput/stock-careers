import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  // Light Mode Styles
  static const _Light light = _Light();

  // Dark Mode Styles
  static const _Dark dark = _Dark();
}

class _Light {
  const _Light();

  TextStyle get headlineLarge => TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  TextStyle get titleMedium => TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );
}

class _Dark {
  const _Dark();

  TextStyle get headlineLarge => TextStyle(
     fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  TextStyle get titleMedium => TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );
}
