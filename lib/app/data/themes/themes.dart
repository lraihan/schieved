import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schieved/app/data/themes/color_themes.dart';

ThemeData themeData = ThemeData(
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: whiteColor,
  primaryColor: primaryColor,
  shadowColor: primaryColor.withOpacity(0.2),
  cardTheme: CardTheme(
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    shadowColor: primaryColor.withOpacity(0.2),
  ),
  colorScheme:
      ColorScheme.fromSwatch(accentColor: secondaryColor).copyWith(primary: primaryColor, secondary: secondaryColor),
  fontFamily: GoogleFonts.poppins().fontFamily,
  iconTheme: IconThemeData(color: primaryColor),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 57),
    displayMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
    displaySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
    headlineLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    headlineMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
    headlineSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    titleSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    labelLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
    labelMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
    labelSmall: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
    bodyLarge: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
    bodyMedium: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
    bodySmall: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
  ).apply(displayColor: blackColor, bodyColor: blackColor, decorationColor: blackColor),
  tabBarTheme: TabBarTheme(
    labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12),
  ),
  appBarTheme: AppBarTheme(color: whiteColor),
);
