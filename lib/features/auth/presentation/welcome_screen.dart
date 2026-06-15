import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_router.dart';
import '../../../widgets/animated_emblem.dart';
import '../../../widgets/gradient_button.dart';
import 'widgets/welcome_hero.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            children: [
              const Center(child: AnimatedEmblem(size: 64))
                  .animate()
                  .fadeIn(duration: 500.ms),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      height: 1.1,
                      letterSpacing: -0.5,
                    ),
                    children: [
                      TextSpan(text: 'ваш AI\n'),
                      TextSpan(text: 'контент-директор'),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 150.ms, duration: 500.ms).slideX(
                  begin: -0.1, end: 0, curve: Curves.easeOut),
              const SizedBox(height: 8),
              const Expanded(child: Center(child: WelcomeHero())),
              Text(
                'Идеи, сценарии и контент-план —\nв одном красивом пространстве\nдля вашего блога.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
              ).animate().fadeIn(delay: 400.ms, duration: 500.ms),
              const SizedBox(height: 28),
              GradientButton(
                label: 'Создать аккаунт',
                onPressed: () => context.push(AppRoutes.authMethod),
              ).animate().fadeIn(delay: 550.ms, duration: 500.ms).slideY(
                  begin: 0.3, end: 0, curve: Curves.easeOut),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => context.push(AppRoutes.login),
                child: Column(
                  children: [
                    Text('уже есть аккаунт?',
                        style: TextStyle(
                            fontSize: 14, color: AppColors.textSecondary)),
                    const SizedBox(height: 2),
                    Text('ВОЙТИ',
                        style: TextStyle(
                            fontSize: 15,
                            color: AppColors.pink,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5)),
                  ],
                ),
              ).animate().fadeIn(delay: 650.ms, duration: 500.ms),
            ],
          ),
        ),
      ),
    );
  }
}
