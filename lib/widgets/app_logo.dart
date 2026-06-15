import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

/// Логотип-«роза» в стеклянном квадрате.
/// Если в assets/images/logo.png лежит реальный логотип — подставляем его,
/// иначе рисуем стилизованную градиентную заглушку.
class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({super.key, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.32),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF7E3E9), Color(0xFFE9B9C7)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.pink.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.spa_rounded,
          size: size * 0.5,
          color: Colors.white.withValues(alpha: 0.9),
        ),
      ),
    );
  }
}
