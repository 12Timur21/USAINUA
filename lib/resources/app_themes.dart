import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';

class AppThemes {
  const AppThemes._();

  static ThemeData light() {
    return ThemeData.light().copyWith(
        // primaryColor: ,
        backgroundColor: AppColors.textSecondary,
        scaffoldBackgroundColor: AppColors.scaffold,
        colorScheme: const ColorScheme.light().copyWith(
            // primary: AppColors.primary,
            // secondary: AppColors.secondary,
            // tertiary: AppColors.tertiary,
            ),
        textTheme: const TextTheme(
          //Покупка доставка
          // titleMedium: const TextStyle(
          //   fontFamily: 'Lato',
          //   fontWeight: AppFonts.extraBold,
          //   fontSize: AppFonts.sizeLarge,
          //   color: AppColors.textPrimary,
          //   letterSpacing: 0.5,
          // ),

          // subtitle1: ,

          //ВХОД
          headlineLarge: TextStyle(
            fontFamily: 'Lato',
            fontWeight: AppFonts.extraBold,
            fontSize: AppFonts.sizeXXXLarge,
            color: AppColors.textPrimary,
            letterSpacing: 0.5,
          ),

          //Текст о безопастност
          bodyText1: TextStyle(
            fontFamily: 'Lato',
            fontWeight: AppFonts.regular,
            fontSize: AppFonts.sizeXSmall,
            color: AppColors.textPrimary,
            letterSpacing: 0.5,
          ),

          headline1: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w800,
            fontSize: 40,
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
            fontFamily: AppFonts.fontFamily,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            elevation: 15,
            shadowColor: AppColors.buttonPrimary.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: AppColors.buttonPrimary,
            primary: AppColors.textQuaternary,
            alignment: Alignment.center,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.scaffold,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: AppColors.textPrimary,
            fontFamily: AppFonts.fontFamily,
            fontWeight: AppFonts.heavy,
            fontSize: AppFonts.sizeLarge,
            letterSpacing: 0.5,
          ),
        )
        // textButtonTheme: TextButtonThemeData(
        //   style: TextButton.styleFrom(
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(16),
        //     ),
        //     backgroundColor: AppColors.buttonPrimary,
        //     primary: AppColors.textQuaternary,
        //     alignment: Alignment.center,
        //     textStyle: const TextStyle(
        //       fontWeight: FontWeight.w800,
        //       fontFamily: 'Lato',
        //       fontSize: 14,
        //     ),
        //     shadowColor: AppColors.buttonPrimary.withOpacity(0.16),
        //   ),
        // ),
        );
  }
}
