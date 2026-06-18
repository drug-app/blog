import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_colors.dart';
import '../../../widgets/app_background.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/pink_tag.dart';
import '../../../widgets/screen_header.dart';

class ScanCompleteScreen extends StatelessWidget {
  const ScanCompleteScreen({super.key});

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
                  const SizedBox(height: 28),
                  const PinkTag('AI-скан завершён')
                      .animate()
                      .fadeIn(duration: 450.ms),
                  const SizedBox(height: 32),
                  Text(
                    'Ваш первый план готов',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.15, end: 0),
                  const SizedBox(height: 14),
                  Text(
                    'AI-директор понял, где сейчас ваш блог\nи с чего лучше начать',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 32),
                  _planCard()
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 500.ms)
                      .slideY(begin: 0.15, end: 0, curve: Curves.easeOut),
                  const SizedBox(height: 20),
                  Text(
                    'Первый план уже подготовлен',
                    style: TextStyle(
                      color: AppColors.textSecondary.withValues(alpha: 0.85),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ).animate().fadeIn(delay: 450.ms),
                  const SizedBox(height: 28),
                  GradientButton(
                    label: 'Посмотреть мой первый план',
                    onPressed: () {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(const SnackBar(
                            content: Text(
                                'Главный экран скоро будет готов 💫')));
                    },
                  ).animate().fadeIn(delay: 550.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _planCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.pink.withValues(alpha: 0.12),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          // Капсула «Стартовый маршрут / Блог в точке роста»
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.pinkLight.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: const [
                Text('Стартовый маршрут',
                    style: TextStyle(
                        fontSize: 12.5,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500)),
                SizedBox(height: 4),
                Text('Блог в точке роста',
                    style: TextStyle(
                        fontSize: 19,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Сейчас важнее всего:',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary)),
          ),
          const SizedBox(height: 12),
          _bullet('усилить позиционирование'),
          _bullet('найти идеи для Reels'),
          _bullet('собрать понятный контент-план'),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 7),
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: AppColors.pink,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 14.5,
                    color: AppColors.textSecondary,
                    height: 1.35)),
          ),
        ],
      ),
    );
  }
}
