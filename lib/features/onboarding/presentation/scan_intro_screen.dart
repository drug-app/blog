import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_router.dart';
import '../../../widgets/app_background.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/pink_tag.dart';
import '../../../widgets/screen_header.dart';
import '../../auth/presentation/widgets/welcome_hero.dart';

class ScanIntroScreen extends StatelessWidget {
  const ScanIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const AppBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const ScreenHeader(),
                  const SizedBox(height: 20),
                  const PinkTag('AI-скан блога')
                      .animate()
                      .fadeIn(duration: 450.ms),
                  const SizedBox(height: 36),
                  Text(
                    'Настроим вашего\nAI-контент-директора',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.15, end: 0),
                  const SizedBox(height: 14),
                  Text(
                    'Ответьте на 5 коротких вопросов —\nи получите первые персональные идеи,\nхуки и рекомендации для блога.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 12),
                  const WelcomeHero(),
                  Text(
                    'Займёт меньше минуты',
                    style: TextStyle(
                      color: AppColors.textSecondary.withValues(alpha: 0.7),
                      fontSize: 13,
                    ),
                  ).animate().fadeIn(delay: 400.ms),
                  const SizedBox(height: 28),
                  GradientButton(
                    label: 'Начать AI-скан',
                    onPressed: () => context.push(AppRoutes.scanStep(0)),
                  ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
