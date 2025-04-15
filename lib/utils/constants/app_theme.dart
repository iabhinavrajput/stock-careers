import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_careers/utils/constants/textstyle.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.amber,
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineLarge: AppTextStyles.light.headlineLarge,
      titleMedium: AppTextStyles.light.titleMedium
    )
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.amber,
    scaffoldBackgroundColor: Color(0xff1F1F39),
       textTheme:GoogleFonts.poppinsTextTheme().copyWith(
      headlineLarge: AppTextStyles.dark.headlineLarge,
            titleMedium: AppTextStyles.light.titleMedium

    )
  );
}
