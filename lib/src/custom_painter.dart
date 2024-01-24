import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class OutLineCustomPainter extends CustomPainter {
  OutLineCustomPainter({
    required this.progress,
    required this.borderColor,
    this.strokeWidth,
    this.animation,
    required this.radius,
  }) : super(repaint: animation);
  double progress; // desirable value for corners side
  Color borderColor;
  double? strokeWidth;
  final Animation<double>? animation;
  double radius;

  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
    double minSide = min(height, width);
    double actualRadius = min(minSide / 2, radius + (radius * 0.15));
    double x = width - actualRadius;
    double y = height - actualRadius;
    Paint paint = Paint()
      ..color =
          progress == 0 && animation == null ? Colors.transparent : borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth ?? 4.0;

    Path path = Path()
      ..moveTo(width / 2, 0)
      ..lineTo(x, 0)
      ..quadraticBezierTo(x + actualRadius, 0, x + actualRadius, actualRadius)
      ..lineTo(x + actualRadius, y)
      ..quadraticBezierTo(
          x + actualRadius, y + actualRadius, x, y + actualRadius)
      ..lineTo(actualRadius, y + actualRadius)
      ..quadraticBezierTo(0, y + actualRadius, 0, y)
      ..lineTo(0, actualRadius)
      ..quadraticBezierTo(0, 0, actualRadius, 0)
      ..close();

    PathMetric pathMetric = path.computeMetrics().first;

    Path extractPath = pathMetric.extractPath(
      animation?.value != null
          ? (pathMetric.length * (animation?.value ?? 0) -
              100 * (0.5 - ((animation?.value ?? 0) - 0.5).abs()))
          : 0,
      animation?.value != null
          ? pathMetric.length * (animation?.value ?? 0)
          : pathMetric.length * (progress),
      startWithMoveTo: true,
    );
    canvas.drawPath(extractPath, paint);
  }

  @override
  bool shouldRepaint(covariant OutLineCustomPainter oldDelegate) {
    return true;
  }
}
