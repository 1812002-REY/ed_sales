import 'package:flutter/material.dart';

class CurvedBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    final path = Path();

    // Top curve
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.7, 0);
    path.quadraticBezierTo(
      size.width * 0.85, size.height * 0.1,
      size.width, size.height * 0.2,
    );
    path.lineTo(size.width, size.height * 0.4);
    path.quadraticBezierTo(
      size.width * 0.8, size.height * 0.35,
      size.width * 0.6, size.height * 0.4,
    );
    path.quadraticBezierTo(
      size.width * 0.3, size.height * 0.45,
      0, size.height * 0.5,
    );
    path.close();

    // Bottom curve
    final bottomPath = Path();
    bottomPath.moveTo(size.width, size.height);
    bottomPath.lineTo(size.width * 0.3, size.height);
    bottomPath.quadraticBezierTo(
      size.width * 0.15, size.height * 0.9,
      0, size.height * 0.8,
    );
    bottomPath.lineTo(0, size.height * 0.6);
    bottomPath.quadraticBezierTo(
      size.width * 0.2, size.height * 0.65,
      size.width * 0.4, size.height * 0.6,
    );
    bottomPath.quadraticBezierTo(
      size.width * 0.7, size.height * 0.55,
      size.width, size.height * 0.5,
    );
    bottomPath.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(bottomPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
