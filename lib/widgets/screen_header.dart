import 'package:flutter/material.dart';
import 'animated_emblem.dart';
import 'glass_back_button.dart';

/// Шапка экрана: кнопка «назад» слева и анимированная эмблема по центру.
class ScreenHeader extends StatelessWidget {
  final bool showBack;
  const ScreenHeader({super.key, this.showBack = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        showBack ? const GlassBackButton() : const SizedBox(width: 48),
        const Spacer(),
        const AnimatedEmblem(size: 44),
        const Spacer(),
        const SizedBox(width: 48),
      ],
    );
  }
}
