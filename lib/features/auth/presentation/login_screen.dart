import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_router.dart';
import '../../../widgets/app_logo.dart';
import '../../../widgets/auth_text_field.dart';
import '../../../widgets/glass_back_button.dart';
import '../../../widgets/gradient_button.dart';
import 'auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await ref
        .read(authControllerProvider.notifier)
        .login(_email.text.trim(), _password.text);
    if (ok && mounted) context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 8),
                Row(
                  children: const [
                    GlassBackButton(),
                    Spacer(),
                    AppLogo(size: 44),
                    Spacer(),
                    SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 60),
                Text('С возвращением',
                        style: Theme.of(context).textTheme.headlineMedium)
                    .animate()
                    .fadeIn(duration: 450.ms)
                    .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
                const SizedBox(height: 12),
                Text(
                  'Войдите, чтобы продолжить работу\nнад своим контент-планом.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ).animate().fadeIn(delay: 150.ms, duration: 450.ms),
                const SizedBox(height: 36),
                AuthTextField(
                  label: 'Email',
                  hint: 'Введите email',
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => (v == null || !v.contains('@'))
                      ? 'Введите корректный email'
                      : null,
                ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.15, end: 0),
                const SizedBox(height: 16),
                AuthTextField(
                  label: 'Пароль',
                  hint: 'Введите пароль',
                  controller: _password,
                  isPassword: true,
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Введите пароль' : null,
                ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.15, end: 0),
                const SizedBox(height: 32),
                GradientButton(
                  label: 'Войти',
                  loading: state.loading,
                  onPressed: _submit,
                ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.2, end: 0),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => context.go(AppRoutes.register),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          fontSize: 14, color: AppColors.textSecondary),
                      children: [
                        TextSpan(text: 'Нет аккаунта? '),
                        TextSpan(
                          text: 'Создать',
                          style: TextStyle(
                              color: AppColors.pink,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: 550.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
