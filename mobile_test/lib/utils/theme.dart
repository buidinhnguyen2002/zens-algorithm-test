import 'package:flutter/material.dart';
import 'package:mobile_test/utils/constants.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: AppColors.white,
    primary: AppColors.green,
    secondary: AppColors.blue,
    onPrimary: Colors.white,
    onError: Colors.white,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: AppColors.grey,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      color: AppColors.grey,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      color: AppColors.greyish,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.white,
    ),
  ),
);
