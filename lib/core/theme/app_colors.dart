import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Фоны — тёплый молочно-розовый
  static const Color background = Color(0xFFFAF4F3);
  static const Color surface = Color(0xFFFFFFFF);

  // Розовый акцент (кнопки, ссылки)
  static const Color pink = Color(0xFFD99BAC);
  static const Color pinkDark = Color(0xFFC97E92);
  static const Color pinkLight = Color(0xFFF3DCE2);

  // Градиент розовой кнопки
  static const Color gradientStart = Color(0xFFEBC2CC);
  static const Color gradientEnd = Color(0xFFD292A4);

  // Текст
  static const Color textPrimary = Color(0xFF1F1F1F);
  static const Color textSecondary = Color(0xFF9A9A9A);
  static const Color textHint = Color(0xFFBDBDBD);

  // Служебные
  static const Color divider = Color(0xFFEEE6E6);
  static const Color error = Color(0xFFE57373);
  static const Color success = Color(0xFF81C784);

  // Стекло (glassmorphism)
  static const Color glass = Color(0x66FFFFFF);
  static const Color glassBorder = Color(0x4DFFFFFF);
}
