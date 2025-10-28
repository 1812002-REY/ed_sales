import 'package:flutter/material.dart';

class WaveClipperGreen extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final xScale = size.width / 612.0;
    final yScale = size.height / 185.1;

    final path = Path();
    // Green path same shape but taller to show below blue
    path.moveTo(0, 150.5 * yScale);
    path.cubicTo(117.5 * xScale, 45.1 * yScale, 225.9 * xScale, 52.6 * yScale, 338.1 * xScale, 111.3 * yScale);
    path.cubicTo(356.2 * xScale, 136.2 * yScale, 478.9 * xScale, 173.8 * yScale, 612.0 * xScale, 220.0 * yScale); // increase for green visibility
    path.lineTo(618.3 * xScale, -6.2 * yScale);
    path.lineTo(0, -0.1 * yScale);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class WaveClipperBlue extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final xScale = size.width / 612.0;
    final yScale = size.height / 185.1;

    final path = Path();
    // Blue path exactly as original
    path.moveTo(0, 150.5 * yScale);
    path.cubicTo(117.5 * xScale, 45.1 * yScale, 225.9 * xScale, 52.6 * yScale, 338.1 * xScale, 111.3 * yScale);
    path.cubicTo(356.2 * xScale, 136.2 * yScale, 478.9 * xScale, 173.8 * yScale, 612.0 * xScale, 185.1 * yScale);
    path.lineTo(618.3 * xScale, -6.2 * yScale);
    path.lineTo(0, -0.1 * yScale);
  path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class LoginTopBar extends StatelessWidget {
  const LoginTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25, // increase height to fit green
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Bottom green layer
          ClipPath(
            clipper: WaveClipperGreen(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFFD8ECE1),
            ),
          ),
          // Top blue layer
          ClipPath(
            clipper: WaveClipperBlue(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFF3F5AA9),
            ),
          ),
        ],
      ),
    );
  }
}
