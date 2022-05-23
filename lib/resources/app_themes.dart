import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';

class AppThemes {
  const AppThemes._();

  static ThemeData light() {
    return ThemeData(
      fontFamily: AppFonts.fontFamily,
      backgroundColor: AppColors.lightBlue,
      scaffoldBackgroundColor: AppColors.scaffold,
      colorScheme: const ColorScheme.light().copyWith(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: AppFonts.sizeXXXLarge,
          fontWeight: AppFonts.bold,
          letterSpacing: 0.5,
          color: AppColors.darkBlue,
        ),
        bodyText1: TextStyle(
          fontSize: AppFonts.sizeXSmall,
          fontWeight: AppFonts.regular,
          letterSpacing: 1,
          color: AppColors.darkBlue,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: AppColors.primary,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        contentPadding: EdgeInsets.only(left: 24),
        hintStyle: TextStyle(
          fontSize: AppFonts.sizeXSmall,
          letterSpacing: 1,
          color: AppColors.noActiveText,
          fontWeight: AppFonts.regular,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 15,
          shadowColor: AppColors.lightGreen.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: AppColors.lightGreen,
          primary: AppColors.darkGreen,
          alignment: Alignment.center,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.scaffold,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppColors.darkBlue,
          fontWeight: AppFonts.heavy,
          fontSize: AppFonts.sizeLarge,
          letterSpacing: 0.5,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        unselectedLabelStyle: TextStyle(
          color: AppColors.darkBlue,
        ),
      ),
      checkboxTheme: const CheckboxThemeData(
        shape: CircleBorder(side: BorderSide.none),
      ),
    );
  }
}
