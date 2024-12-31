import 'colors.dart';
import 'package:flutter/material.dart';
import 'sizes.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        color: AppColors.primary,
        titleTextStyle: TextStyle(
          color: AppColors.text,
          fontSize: AppSizes.fontSizeLarge,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge:
            TextStyle(color: AppColors.text, fontSize: AppSizes.fontSizeMedium),
        bodyMedium:
            TextStyle(color: AppColors.text, fontSize: AppSizes.fontSizeSmall),
        displayLarge: TextStyle(
            color: AppColors.text,
            fontSize: AppSizes.fontSizeExtraLarge,
            fontWeight: FontWeight.bold),
        displayMedium: TextStyle(
            color: AppColors.text,
            fontSize: AppSizes.fontSizeLarge,
            fontWeight: FontWeight.bold),
        displaySmall: TextStyle(
            color: AppColors.text,
            fontSize: AppSizes.fontSizeMedium,
            fontWeight: FontWeight.bold),
        labelLarge: TextStyle(
            color: AppColors.text,
            fontSize: AppSizes.fontSizeMedium,
            fontWeight: FontWeight.bold),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
        height: AppSizes.buttonHeight,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primary,
          textStyle: const TextStyle(
              fontSize: AppSizes.fontSizeMedium, fontWeight: FontWeight.bold),
          minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall),
          borderSide: const BorderSide(color: AppColors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        labelStyle: const TextStyle(color: AppColors.grey),
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        surface: AppColors.background,
        onSurface: AppColors.text,
        error: AppColors.error,
        onError: Colors.white,
      ),
    );
  }
}
