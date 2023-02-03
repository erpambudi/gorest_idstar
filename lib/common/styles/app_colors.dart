import 'package:flutter/material.dart';

enum ShadeTypes {
  negative10,
  positive10,
}

class AppColors {
  static const Color brand = Color(0xFF3B8EEB);

  static const Color fill = Color(0xFFF2F3F7);

  static Color brandShades(ShadeTypes shadeTypes) {
    switch (shadeTypes) {
      case ShadeTypes.negative10:
        return const Color(0xFF3D91EF);
      case ShadeTypes.positive10:
        return const Color(0xFF4483CB);
      default:
        return brand;
    }
  }

  static const Color backgroundColor = Color(0xFFFFFFFF);

  static const Color black = Color(0xFF131313);

  static const Color white = Color(0xFFFFFFFF);

  static const Color grey = Colors.grey;

  static Color greyShades(ShadeTypes shadeTypes) {
    switch (shadeTypes) {
      case ShadeTypes.negative10:
        return const Color(0xFFB6BEC4);
      case ShadeTypes.positive10:
        return const Color(0xFFE8EBF4);
      default:
        return grey;
    }
  }
}
