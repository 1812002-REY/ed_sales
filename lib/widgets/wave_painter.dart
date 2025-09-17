import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final path = Path();

    // Start at top-left
    path.moveTo(0, 0);

    // Top edge (straight line across the top)
    path.lineTo(size.width, 0);

    // Right edge straight down
    path.lineTo(size.width, size.height * 0.7);

    // Create wave at the bottom using quadratic bezier
    path.quadraticBezierTo(
      size.width * 0.75, size.height, // control point
      size.width * 0.5, size.height * 0.7, // end point
    );
    path.quadraticBezierTo(
      size.width * 0.25, size.height * 0.4, // control point
      0, size.height * 0.7, // end point
    );

    // Close back to top-left
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}