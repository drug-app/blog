import 'package:flutter/material.dart';

/// Иконка Apple (системная).
class AppleIcon extends StatelessWidget {
  final double size;
  const AppleIcon({super.key, this.size = 22});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.apple, size: size, color: Colors.black);
  }
}

/// Фирменная иконка VK — синяя плитка с белыми буквами.
class VkIcon extends StatelessWidget {
  final double size;
  const VkIcon({super.key, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF0077FF),
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      child: Center(
        child: Text(
          'VK',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: size * 0.45,
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }
}

/// Фирменная иконка Яндекс ID — красный кружок с белой «Я».
class YandexIcon extends StatelessWidget {
  final double size;
  const YandexIcon({super.key, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFFFC3F1D),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          'Я',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: size * 0.58,
          ),
        ),
      ),
    );
  }
}
