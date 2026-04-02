import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      cardColor: AppColors.cardLight,
      dividerColor: AppColors.borderLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        surface: AppColors.cardLight,
        onPrimary: Colors.white,
        onSecondary: AppColors.primaryLight,
        onSurface: AppColors.foregroundLight,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
        bodyColor: AppColors.foregroundLight,
        displayColor: AppColors.foregroundLight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.foregroundLight),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      cardColor: AppColors.cardDark,
      dividerColor: AppColors.borderDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDark,
        secondary: AppColors.secondaryDark,
        surface: AppColors.cardDark,
        onPrimary: Colors.white,
        onSecondary: Color(0xFFA7F3D0),
        onSurface: AppColors.foregroundDark,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
        bodyColor: AppColors.foregroundDark,
        displayColor: AppColors.foregroundDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.foregroundDark),
      ),
    );
  }
}
