import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/auth_controller.dart';
import 'routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Пытаемся поднять Supabase. Если ключи ещё не заданы — приложение
  // всё равно запускается, чтобы можно было листать экраны.
  bool supabaseReady = false;
  final hasKeys = AppConstants.supabaseUrl.startsWith('http') &&
      !AppConstants.supabaseAnonKey.startsWith('YOUR_');
  if (hasKeys) {
    try {
      await Supabase.initialize(
        url: AppConstants.supabaseUrl,
        anonKey: AppConstants.supabaseAnonKey,
      );
      supabaseReady = true;
    } catch (_) {
      supabaseReady = false;
    }
  }

  runApp(
    ProviderScope(
      overrides: [
        supabaseReadyProvider.overrideWith((_) => supabaseReady),
      ],
      child: const BloomApp(),
    ),
  );
}

class BloomApp extends StatelessWidget {
  const BloomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Bloom AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
