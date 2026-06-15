import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../features/auth/presentation/splash_screen.dart';
import '../features/auth/presentation/welcome_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/register_screen.dart';
import '../features/onboarding/presentation/questionnaire_screen.dart';
import '../features/onboarding/presentation/onboarding_nav_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/ideas/presentation/ideas_screen.dart';
import '../features/saved/presentation/saved_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../widgets/main_scaffold.dart';

class AppRoutes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const register = '/register';
  static const questionnaire = '/questionnaire';
  static const onboardingNav = '/onboarding-nav';
  static const home = '/home';
  static const ideas = '/ideas';
  static const saved = '/saved';
  static const profile = '/profile';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.welcome,
      builder: (_, __) => const WelcomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (_, __) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.questionnaire,
      builder: (_, __) => const QuestionnaireScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboardingNav,
      builder: (_, __) => const OnboardingNavScreen(),
    ),
    ShellRoute(
      builder: (_, __, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (_, __) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.ideas,
          builder: (_, __) => const IdeasScreen(),
        ),
        GoRoute(
          path: AppRoutes.saved,
          builder: (_, __) => const SavedScreen(),
        ),
        GoRoute(
          path: AppRoutes.profile,
          builder: (_, __) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
