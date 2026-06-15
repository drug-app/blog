import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

/// Главная эмблема-«роза» в стеклянном squircle.
/// Непрерывно и мягко анимирована: дыхание (масштаб), медленное вращение
/// лепестков, пульсирующее свечение и световой блик-проблеск по стеклу.
class AnimatedEmblem extends StatefulWidget {
  final double size;
  const AnimatedEmblem({super.key, this.size = 72});

  @override
  State<AnimatedEmblem> createState() => _AnimatedEmblemState();
}

class _AnimatedEmblemState extends State<AnimatedEmblem>
    with TickerProviderStateMixin {
  late final AnimationController _spin; // медленное вращение лепестков
  late final AnimationController _breath; // дыхание + свечение
  late final AnimationController _shine; // блик по стеклу

  @override
  void initState() {
    super.initState();
    _spin = AnimationController(
        vsync: this, duration: const Duration(seconds: 24))
      ..repeat();
    _breath = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2600))
      ..repeat(reverse: true);
    _shine = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3400))
      ..repeat();
  }

  @override
  void dispose() {
    _spin.dispose();
    _breath.dispose();
    _shine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.size;
    return AnimatedBuilder(
      animation: Listenable.merge([_spin, _breath, _shine]),
      builder: (context, _) {
        final breath = Curves.easeInOut.transform(_breath.value);
        final scale = 0.97 + breath * 0.06;
        final glow = 0.25 + breath * 0.30;
        return SizedBox(
          width: s * 1.4,
          height: s * 1.4,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Пульсирующее розовое свечение
              Container(
                width: s * 1.4,
                height: s * 1.4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.pink.withValues(alpha: glow),
                      AppColors.pink.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
              // Стеклянный squircle с розой
              Transform.scale(
                scale: scale,
                child: Container(
                  width: s,
                  height: s,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(s * 0.34),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFCEEF2), Color(0xFFF2D2DC)],
                    ),
                    border: Border.all(
                        color: Colors.white.withValues(alpha: 0.85),
                        width: 1.4),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.pink.withValues(alpha: 0.35),
                        blurRadius: 22,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: CustomPaint(
                    painter: _RosePainter(rotation: _spin.value * 2 * math.pi),
                  ),
                ),
              ),
              // Световой блик, бегущий по стеклу
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(s * 0.34),
                  child: Align(
                    alignment: Alignment(-1.6 + _shine.value * 3.2, -1),
                    child: Transform.rotate(
                      angle: -0.5,
                      child: Container(
                        width: s * 0.30,
                        height: s * 1.6,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withValues(alpha: 0),
                              Colors.white.withValues(alpha: 0.45),
                              Colors.white.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Рисует стилизованную розу из слоёв лепестков.
class _RosePainter extends CustomPainter {
  final double rotation;
  _RosePainter({required this.rotation});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final r = size.width * 0.30;
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);

    // Внешний слой лепестков
    _petalRing(canvas, count: 6, radius: r, petalSize: r * 0.95,
        offset: 0, colors: const [Color(0xFFE9A7BA), Color(0xFFD98098)]);
    // Средний слой (смещён)
    _petalRing(canvas, count: 6, radius: r * 0.55, petalSize: r * 0.72,
        offset: math.pi / 6,
        colors: const [Color(0xFFF0BCC9), Color(0xFFE193A8)]);
    // Сердцевина
    final corePaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFFFBE3EA), Color(0xFFE7A6B8)],
      ).createShader(Rect.fromCircle(center: Offset.zero, radius: r * 0.4));
    canvas.drawCircle(Offset.zero, r * 0.32, corePaint);
    canvas.restore();
  }

  void _petalRing(Canvas canvas,
      {required int count,
      required double radius,
      required double petalSize,
      required double offset,
      required List<Color> colors}) {
    for (int i = 0; i < count; i++) {
      final angle = offset + i * 2 * math.pi / count;
      final cx = math.cos(angle) * radius * 0.5;
      final cy = math.sin(angle) * radius * 0.5;
      final paint = Paint()
        ..shader = LinearGradient(colors: colors).createShader(
            Rect.fromCircle(center: Offset(cx, cy), radius: petalSize));
      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(angle + math.pi / 2);
      final rect = Rect.fromCenter(
          center: Offset.zero, width: petalSize * 0.7, height: petalSize);
      canvas.drawOval(rect, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _RosePainter old) => old.rotation != rotation;
}
