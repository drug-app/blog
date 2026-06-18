import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

/// Вторичная «призрачная» кнопка — светлая, со светло-розовой заливкой.
class SecondaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  const SecondaryButton({super.key, required this.label, required this.onPressed});

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          height: 58,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [
                AppColors.pinkLight.withValues(alpha: 0.9),
                AppColors.pinkLight.withValues(alpha: 0.6),
              ],
            ),
            border: Border.all(color: AppColors.pinkLight, width: 1),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: const TextStyle(
                color: AppColors.pinkDark,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
