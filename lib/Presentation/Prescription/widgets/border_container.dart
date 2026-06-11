import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashedBorderContainer extends StatelessWidget {
  final Widget child;

  const DashedBorderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: DashedBorderPainter(), child: child);
  }
}

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 10.w;
    double dashSpace = 4.w;

    final paint = Paint()
      ..color = const Color(0xFFB8CDC7)
      ..strokeWidth = 2.w
      ..style = PaintingStyle.stroke;

    final rect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(20.r),
    );

    final path = Path()..addRRect(rect);

    PathMetrics metrics = path.computeMetrics();

    for (var metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final extractPath = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

