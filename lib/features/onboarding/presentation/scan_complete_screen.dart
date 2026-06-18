import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_router.dart';
import '../../../widgets/animated_emblem.dart';
import '../../../widgets/app_background.dart';
import '../../../widgets/gradient_button.dart';
import 'questionnaire_controller.dart';

class ScanCompleteScreen extends ConsumerWidget {
  const ScanCompleteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(questionnaireProvider).name;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const AppBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AnimatedEmblem(size: 96)
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .scale(
                          begin: const Offset(0.6, 0.6),
                          curve: Curves.easeOutBack,
                          duration: 700.ms),
                  const SizedBox(height: 32),
                  Text(
                    'AI-память активирована ✓',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 14),
                  Text(
                    name.isEmpty
                        ? 'Теперь я знаю твой блог и готов\nпредлагать идеи, сценарии и контент-план.'
                        : '$name, теперь я знаю твой блог и готов\nпредлагать идеи, сценарии и контент-план.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ).animate().fadeIn(delay: 450.ms),
                  const SizedBox(height: 40),
                  GradientButton(
                    label: 'Перейти в приложение',
                    onPressed: () => context.go(AppRoutes.home),
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2, end: 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
