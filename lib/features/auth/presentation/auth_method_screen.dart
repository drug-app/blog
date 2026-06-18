import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_router.dart';
import '../../../widgets/animated_emblem.dart';
import '../../../widgets/app_background.dart';
import '../../../widgets/brand_icons.dart';
import '../../../widgets/glass_back_button.dart';
import '../../../widgets/social_button.dart';
import 'auth_controller.dart';

class AuthMethodScreen extends ConsumerWidget {
  const AuthMethodScreen({super.key});

  void _soon(BuildContext context, String name) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Вход через $name скоро будет доступен')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authControllerProvider, (_, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(next.error!)));
      }
    });

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
                  Row(
                    children: const [
                      GlassBackButton(),
                      Spacer(),
                      AnimatedEmblem(size: 44),
                      Spacer(),
                      SizedBox(width: 48),
                    ],
                  ),
                  const Spacer(flex: 2),
                  Text('Создайте аккаунт',
                          style: Theme.of(context).textTheme.headlineMedium)
                      .animate()
                      .fadeIn(duration: 450.ms)
                      .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
                  const SizedBox(height: 12),
                  Text(
                    'Выберите удобный способ входа —\nмы сохраним ваши идеи, сценарии и контент-план.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ).animate().fadeIn(delay: 150.ms, duration: 450.ms),
                  const SizedBox(height: 36),
                  SocialButton(
                    icon: const AppleIcon(),
                    label: 'Продолжить с Apple',
                    onPressed: () async {
                      final ok = await ref
                          .read(authControllerProvider.notifier)
                          .apple();
                      if (ok && context.mounted) context.go(AppRoutes.name);
                    },
                  ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 14),
                  SocialButton(
                    icon: const VkIcon(),
                    label: 'Продолжить с VK',
                    onPressed: () => _soon(context, 'VK'),
                  ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 14),
                  SocialButton(
                    icon: const YandexIcon(),
                    label: 'Продолжить с Яндекс ID',
                    onPressed: () => _soon(context, 'Яндекс ID'),
                  ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 14),
                  SocialButton(
                    icon: const Icon(Icons.alternate_email_rounded,
                        size: 20, color: AppColors.pinkDark),
                    label: 'Продолжить с Email',
                    onPressed: () => context.push(AppRoutes.register),
                  ).animate().fadeIn(delay: 550.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.login),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontSize: 14, color: AppColors.textSecondary),
                        children: [
                          TextSpan(text: 'Уже есть аккаунт? '),
                          TextSpan(
                            text: 'Войти',
                            style: TextStyle(
                                color: AppColors.pink,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 650.ms),
                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
