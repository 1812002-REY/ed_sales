import 'package:flutter/material.dart';

class TopWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.shade300
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);

    // Left side down
    path.lineTo(0, size.height * 0.7);

    // Wave steep to the right
    path.quadraticBezierTo(
      size.width * 0.25, size.height, // control point
      size.width, size.height * 0.6,  // end point
    );

    // Right edge up
    path.lineTo(size.width, 0);

    // Close shape
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BottomWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.shade600
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.6);

    // Wave steep to the left but upside down
    path.quadraticBezierTo(
      size.width * 1.5, size.height, // control point pulled down & centered
      size.width, size.height * 0.9,  // end point
    );

    // Top edge
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    // Close shape
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
