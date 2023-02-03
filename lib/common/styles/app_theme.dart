import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_values.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.brand,
      splashColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      backgroundColor: AppColors.backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: AppColors.brand,
        secondary: AppColors.brand,
      ),

      //Font Theme
      fontFamily: "Product-Sans",

      //AppBar Theme
      appBarTheme: AppBarTheme(
        elevation: AppValues.elevationZero,
        centerTitle: false,
        titleTextStyle: AppTextStyle.appBarTitle,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.brandShades(
            ShadeTypes.positive10,
          ),
          statusBarIconBrightness: Brightness.light,
        ),
      ),

      //Text Field Theme
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: AppColors.greyShades(ShadeTypes.negative10),
          fontSize: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppValues.smallRadius),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        fillColor: AppColors.fill,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppValues.extraSmallPadding,
          horizontal: AppValues.padding,
        ),
      ),

      //Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.brand,
          elevation: AppValues.elevationZero,
          padding: const EdgeInsets.symmetric(
            vertical: AppValues.buttonVerticalPadding,
            horizontal: AppValues.largePadding,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
