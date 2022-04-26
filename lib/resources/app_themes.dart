import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';

class AppThemes {
  const AppThemes._();

  static ThemeData light() {
    return ThemeData.light().copyWith(
      // Define the default colors.
      colorScheme: const ColorScheme.light().copyWith(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      scaffoldBackgroundColor: AppColors.scaffold,
    );
  }
}
