import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        fontSize: 32,
        fontWeight: FontWeight.w700,
      );

  TextStyle get headlineMedium => GoogleFonts.poppins(
        fontSize: 30,
        fontWeight: FontWeight.w600,
      );

  TextStyle get headlineSmall => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
      );

  TextStyle get titleMedium => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
      );
  TextStyle get titleSmall => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
   
      );

  TextStyle get bodyMedium => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  TextStyle get displaySmall => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,

      );

  TextStyle get displayLarge => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      );

  TextStyle get labelMedium => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      );
}

class _Dark {
  const _Dark();

  TextStyle get headlineLarge => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
      );

  TextStyle get headlineMedium => GoogleFonts.poppins(
        fontSize: 30,
        fontWeight: FontWeight.w600,
      );

  TextStyle get headlineSmall => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
      );

  TextStyle get titleMedium => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
      );
  TextStyle get titleSmall => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,

      );

  TextStyle get bodyMedium => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  TextStyle get displaySmall => GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w500,

      color: Colors.white);

  TextStyle get displayLarge => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins', 
      );

  TextStyle get labelMedium => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        // color: Colors.white
      );
}

class _Fixed {
  const _Fixed();

  TextStyle get smallButtonText => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      );

      TextStyle get userName =>  GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.white
      );

       TextStyle get label =>  GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white
      );
}
