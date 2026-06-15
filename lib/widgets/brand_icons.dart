import 'package:flutter/material.dart';

/// Фирменная четырёхцветная «G» Google, нарисованная вручную.
class GoogleIcon extends StatelessWidget {
  final double size;
  const GoogleIcon({super.key, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _GooglePainter()),
    );
  }
}

class _GooglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final c = Offset(w / 2, w / 2);
    final r = w / 2;
    final stroke = w * 0.22;
    final rect = Rect.fromCircle(center: c, radius: r - stroke / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;

    // Красный (верх-лево)
    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(rect, _rad(-25), _rad(-115), false, paint);
    // Жёлтый (низ-лево)
    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(rect, _rad(-140), _rad(-75), false, paint);
    // Зелёный (низ)
    paint.color = const Color(0xFF34A853);
    canvas.drawArc(rect, _rad(145), _rad(75), false, paint);
    // Синий (право)
    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(rect, _rad(0), _rad(90), false, paint);

    // Синяя перекладина «G»
    final barPaint = Paint()..color = const Color(0xFF4285F4);
    canvas.drawRect(
      Rect.fromLTWH(c.dx, c.dy - stroke / 2, r, stroke),
      barPaint,
    );
  }

  double _rad(double deg) => deg * 3.1415926535 / 180;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Иконка Apple (системная).
class AppleIcon extends StatelessWidget {
  final double size;
  const AppleIcon({super.key, this.size = 22});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.apple, size: size, color: Colors.black);
  }
}
