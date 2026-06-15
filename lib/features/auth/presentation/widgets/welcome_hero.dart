import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';

/// Стеклянный squircle с центральной надписью и парящими чипами вокруг —
/// точная пересборка под макет экрана 1.
class WelcomeHero extends StatelessWidget {
  const WelcomeHero({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Мягкое розовое свечение под пузырём
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.pink.withValues(alpha: 0.28),
                  AppColors.pink.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),

          // Сверкающие звёздочки
          ..._sparkles(),

          // Центральный стеклянный squircle
          _glassCard()
              .animate()
              .fadeIn(duration: 600.ms)
              .scale(begin: const Offset(0.88, 0.88), curve: Curves.easeOutBack),

          // Чипы вокруг
          _chip('Идеи', Icons.lightbulb_outline,
              const Alignment(-0.92, -0.78), 0),
          _chip('Сценарий', Icons.movie_creation_outlined,
              const Alignment(0.95, -0.72), 150),
          _chip('План', Icons.calendar_today_outlined,
              const Alignment(-1.02, 0.02), 300),
          _chip('Стратегия', Icons.auto_graph_rounded,
              const Alignment(1.04, 0.05), 250),
          _chip('Reels', Icons.play_circle_outline,
              const Alignment(-0.78, 0.82), 450),
          _chip('Stories', Icons.amp_stories_outlined,
              const Alignment(0.02, 0.98), 550),
          _chip('Hooks', Icons.bolt_outlined,
              const Alignment(0.82, 0.84), 650),
        ],
      ),
    );
  }

  Widget _glassCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(54),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          width: 218,
          height: 188,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(54),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.65),
                AppColors.pinkLight.withValues(alpha: 0.45),
              ],
            ),
            border: Border.all(
                color: Colors.white.withValues(alpha: 0.75), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.pink.withValues(alpha: 0.22),
                blurRadius: 34,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Сегодня для вас',
                  style: TextStyle(
                      fontSize: 11.5,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              Text('3 идеи Reels',
                  style: TextStyle(
                      fontSize: 19,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2)),
              SizedBox(height: 2),
              Text('1 сценарий',
                  style: TextStyle(
                      fontSize: 19,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2)),
              SizedBox(height: 8),
              Text('контент-план на неделю',
                  style: TextStyle(
                      fontSize: 11.5,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _sparkles() {
    const positions = [
      Alignment(-0.45, -0.62),
      Alignment(0.5, -0.5),
      Alignment(-0.62, 0.3),
      Alignment(0.6, 0.42),
      Alignment(0.0, -0.9),
      Alignment(-0.2, 0.62),
    ];
    return [
      for (int i = 0; i < positions.length; i++)
        Align(
          alignment: positions[i],
          child: Text('✦',
                  style: TextStyle(
                      fontSize: i.isEven ? 14 : 10,
                      color: AppColors.pink.withValues(alpha: 0.5)))
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .fadeIn(delay: (i * 200).ms)
              .then()
              .fade(begin: 1, end: 0.3, duration: 1600.ms),
        ),
    ];
  }

  Widget _chip(String label, IconData icon, Alignment align, int delayMs) {
    return Align(
      alignment: align,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
              color: AppColors.pinkLight.withValues(alpha: 0.8), width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.pink.withValues(alpha: 0.16),
              blurRadius: 16,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: AppColors.pinkLight.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(icon, size: 13, color: AppColors.pinkDark),
            ),
            const SizedBox(width: 7),
            Text(label,
                style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary)),
          ],
        ),
      )
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .fadeIn(delay: delayMs.ms, duration: 500.ms)
          .then()
          .moveY(begin: 0, end: -6, duration: 2400.ms, curve: Curves.easeInOut),
    );
  }
}
