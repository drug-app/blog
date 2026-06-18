import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_router.dart';
import '../../../widgets/app_background.dart';
import '../../../widgets/gradient_button.dart';
import '../../../widgets/screen_header.dart';
import '../../../widgets/secondary_button.dart';
import 'questionnaire_controller.dart';

class NameScreen extends ConsumerStatefulWidget {
  const NameScreen({super.key});

  @override
  ConsumerState<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends ConsumerState<NameScreen> {
  final _name = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _go(String route) {
    ref.read(questionnaireProvider.notifier).setName(_name.text.trim());
    context.push(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const AppBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const ScreenHeader(),
                  const Spacer(flex: 2),
                  Text('Как вас зовут?',
                          style: Theme.of(context).textTheme.headlineMedium)
                      .animate()
                      .fadeIn(duration: 450.ms)
                      .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
                  const SizedBox(height: 12),
                  Text(
                    'Так AI-директор будет обращаться к вам\nи персонализировать рекомендации.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ).animate().fadeIn(delay: 150.ms),
                  const SizedBox(height: 32),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.pink.withValues(alpha: 0.10),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Введите ваше имя',
                        hintStyle: TextStyle(
                            color: AppColors.textHint,
                            fontWeight: FontWeight.w400),
                        filled: false,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.15, end: 0),
                  const Spacer(flex: 3),
                  GradientButton(
                    label: 'Продолжить',
                    onPressed: () => _go(AppRoutes.scanIntro),
                  ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 14),
                  SecondaryButton(
                    label: 'Начать AI-скан',
                    onPressed: () => _go(AppRoutes.scanIntro),
                  ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.2, end: 0),
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
