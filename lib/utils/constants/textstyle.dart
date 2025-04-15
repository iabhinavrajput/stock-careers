import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  // Light Mode Styles
  static const _Light light = _Light();

  // Dark Mode Styles
  static const _Dark dark = _Dark();

  static const _Fixed fixed = _Fixed();
}

class _Light {
  const _Light();

  TextStyle get headlineLarge => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
      );

  TextStyle get titleMedium => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
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
        fontWeight: FontWeight.w400,
      );
}

class _Fixed {
  const _Fixed();

  TextStyle get smallButtonText => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      );
}
