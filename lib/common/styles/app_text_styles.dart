import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle {
  static TextStyle get appBarTitle => TextStyle(
        color: AppColors.greyShades(ShadeTypes.positive10),
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.15,
        fontFamily: "Product-Sans",
      );

  static TextStyle get title => const TextStyle(
        color: AppColors.black,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get subtitle => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get mainBlue => const TextStyle(
        color: AppColors.brand,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get actionDialog => const TextStyle(
        color: AppColors.brand,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get snackbar => const TextStyle(
        color: AppColors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: "Product-Sans",
      );
}
