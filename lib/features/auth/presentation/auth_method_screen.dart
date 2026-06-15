import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_router.dart';
import '../../../widgets/app_logo.dart';
import '../../../widgets/brand_icons.dart';
import '../../../widgets/glass_back_button.dart';
import '../../../widgets/social_button.dart';
import 'auth_controller.dart';

class AuthMethodScreen extends ConsumerWidget {
  const AuthMethodScreen({super.key});

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  const GlassBackButton(),
                  const Spacer(),
                  const AppLogo(size: 44),
                  const Spacer(),
                  const SizedBox(width: 48),
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
                onPressed: () => ref.read(authControllerProvider.notifier).apple(),
              ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 14),
              SocialButton(
                icon: const GoogleIcon(),
                label: 'Продолжить с Google',
                onPressed: () =>
                    ref.read(authControllerProvider.notifier).google(),
              ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 14),
              SocialButton(
                icon: const Icon(Icons.alternate_email_rounded,
                    size: 20, color: AppColors.pinkDark),
                label: 'Продолжить с Email',
                onPressed: () => context.push(AppRoutes.register),
              ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 24),
              _loginLink(context),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginLink(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.login),
      child: RichText(
        text: const TextSpan(
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          children: [
            TextSpan(text: 'Уже есть аккаунт? '),
            TextSpan(
              text: 'Войти',
              style: TextStyle(
                  color: AppColors.pink, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 550.ms);
  }
}
