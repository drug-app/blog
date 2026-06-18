import 'package:go_router/go_router.dart';

import '../features/auth/presentation/splash_screen.dart';
import '../features/auth/presentation/welcome_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/register_screen.dart';
import '../features/auth/presentation/auth_method_screen.dart';
import '../features/onboarding/presentation/name_screen.dart';
import '../features/onboarding/presentation/scan_intro_screen.dart';
import '../features/onboarding/presentation/scan_question_screen.dart';
import '../features/onboarding/presentation/scan_loading_screen.dart';
import '../features/onboarding/presentation/scan_complete_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/ideas/presentation/ideas_screen.dart';
import '../features/saved/presentation/saved_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../widgets/main_scaffold.dart';

class AppRoutes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const authMethod = '/auth-method';
  static const login = '/login';
  static const register = '/register';
  static const name = '/onboarding/name';
  static const scanIntro = '/onboarding/scan-intro';
  static const scanLoading = '/onboarding/scan-loading';
  static const scanComplete = '/onboarding/scan-complete';
  static String scanStep(int step) => '/onboarding/scan/$step';
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
      path: AppRoutes.authMethod,
      builder: (_, __) => const AuthMethodScreen(),
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
      path: AppRoutes.name,
      builder: (_, __) => const NameScreen(),
    ),
    GoRoute(
      path: AppRoutes.scanIntro,
      builder: (_, __) => const ScanIntroScreen(),
    ),
    GoRoute(
      path: '/onboarding/scan/:step',
      builder: (_, state) => ScanQuestionScreen(
        step: int.tryParse(state.pathParameters['step'] ?? '0') ?? 0,
      ),
    ),
    GoRoute(
      path: AppRoutes.scanLoading,
      builder: (_, __) => const ScanLoadingScreen(),
    ),
    GoRoute(
      path: AppRoutes.scanComplete,
      builder: (_, __) => const ScanCompleteScreen(),
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
