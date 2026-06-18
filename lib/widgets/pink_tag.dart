import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

/// Светло-розовая капсула-метка (например «AI-скан 1 из 5»).
class PinkTag extends StatelessWidget {
  final String text;
  const PinkTag(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.pinkLight.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.pinkDark,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
