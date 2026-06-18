import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_router.dart';
import '../../../widgets/animated_emblem.dart';
import '../../../widgets/app_background.dart';

class ScanLoadingScreen extends StatefulWidget {
  const ScanLoadingScreen({super.key});

  @override
  State<ScanLoadingScreen> createState() => _ScanLoadingScreenState();
}

class _ScanLoadingScreenState extends State<ScanLoadingScreen> {
  static const _steps = [
    'Анализирую ваши ответы…',
    'Собираю позиционирование…',
    'Подбираю идеи и хуки…',
    'Готовлю первый план…',
  ];
  int _i = 0;

  @override
  void initState() {
    super.initState();
    _tick();
  }

  void _tick() {
    Future.delayed(const Duration(milliseconds: 750), () {
      if (!mounted) return;
      if (_i < _steps.length - 1) {
        setState(() => _i++);
        _tick();
      } else {
        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) context.pushReplacement(AppRoutes.scanComplete);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const AppBackground(),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AnimatedEmblem(size: 92),
                  const SizedBox(height: 40),
                  Text(
                    'AI сканирует ваш блог',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      _steps[_i],
                      key: ValueKey(_i),
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: 160,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: (_i + 1) / _steps.length,
                        minHeight: 6,
                        backgroundColor: AppColors.pinkLight,
                        valueColor:
                            const AlwaysStoppedAnimation(AppColors.pink),
                      ),
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 500.ms),
            ),
          ),
        ],
      ),
    );
  }
}
