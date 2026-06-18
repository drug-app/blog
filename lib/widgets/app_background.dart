import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Фирменная подложка экрана: тёплый молочно-розовый фон,
/// мягкие розовые блобы по углам и парящие звёздочки.
/// Кладётся самым нижним слоем под контент каждого экрана.
class AppBackground extends StatelessWidget {
  const AppBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipRect(
        child: Stack(
          children: [
            // Базовый градиент
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFBF4F4), Color(0xFFF7EEF0)],
                ),
              ),
              child: SizedBox.expand(),
            ),

            // Блобы
            _blob(const Alignment(-1.2, -1.05), 220, 0.55),
            _blob(const Alignment(1.25, -0.7), 140, 0.45),
            _blob(const Alignment(-1.15, 0.1), 120, 0.40),
            _blob(const Alignment(1.2, 0.45), 200, 0.50),
            _blob(const Alignment(-1.1, 1.1), 240, 0.55),
            _blob(const Alignment(1.3, 1.15), 180, 0.45),

            // Звёздочки
            ..._sparkles(),
          ],
        ),
      ),
    );
  }

  Widget _blob(Alignment align, double size, double opacity) {
    return Align(
      alignment: align,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              const Color(0xFFEAD2DC).withValues(alpha: opacity),
              const Color(0xFFEAD2DC).withValues(alpha: 0),
            ],
          ),
        ),
      )
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .moveY(
              begin: 0,
              end: -10,
              duration: 5000.ms,
              curve: Curves.easeInOut),
    );
  }

  List<Widget> _sparkles() {
    const data = <(Alignment, double)>[
      (Alignment(0.55, -0.92), 16),
      (Alignment(-0.7, -0.62), 12),
      (Alignment(0.35, -0.5), 22),
      (Alignment(0.78, -0.32), 12),
      (Alignment(-0.55, -0.18), 14),
      (Alignment(0.5, 0.25), 16),
      (Alignment(-0.75, 0.55), 22),
      (Alignment(0.62, 0.62), 14),
      (Alignment(-0.5, 0.95), 12),
    ];
    return [
      for (int i = 0; i < data.length; i++)
        Align(
          alignment: data[i].$1,
          child: Text(
            '✦',
            style: TextStyle(
              fontSize: data[i].$2,
              color: const Color(0xFFD7C4CC).withValues(alpha: 0.65),
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .fade(
                  begin: 0.35,
                  end: 0.85,
                  delay: (i * 150).ms,
                  duration: 1800.ms)
              .scaleXY(begin: 0.9, end: 1.1, duration: 1800.ms),
        ),
    ];
  }
}
