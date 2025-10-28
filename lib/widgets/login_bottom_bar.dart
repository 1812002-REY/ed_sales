import 'package:flutter/material.dart';

// ------------------ Clipper for Wave ------------------
class WaveClipper extends CustomClipper<Path> {
  const WaveClipper({this.extraHeight = 0});

  final double extraHeight;

  @override
  Path getClip(Size size) {
    final xScale = size.width / 612.0;
    final yScale = size.height / 185.1;

    final path = Path();

    path.moveTo(-2.8 * xScale, (174.6 + extraHeight) * yScale);
    path.cubicTo(
      -2.8 * xScale, (174.6 + extraHeight) * yScale,
      167.7 * xScale, (66.7 + extraHeight) * yScale,
      334.0 * xScale, (80.6 + extraHeight) * yScale,
    );
    path.cubicTo(
      334.0 * xScale, (80.6 + extraHeight) * yScale,
      390.6 * xScale, (86.5 + extraHeight) * yScale,
      426.3 * xScale, (96.1 + extraHeight) * yScale,
    );
    path.cubicTo(
      426.3 * xScale, (96.1 + extraHeight) * yScale,
      496.8 * xScale, (110.0 + extraHeight) * yScale,
      552.9 * xScale, (60.0 + extraHeight) * yScale,
    );
    path.cubicTo(
      552.9 * xScale, (60.0 + extraHeight) * yScale,
      586.7 * xScale, (33.6 + extraHeight) * yScale,
      613.7 * xScale, (0.0 + extraHeight) * yScale,
    );

    // Close the bottom
    path.lineTo(613.7 * xScale, size.height);
    path.lineTo(-2.8 * xScale, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ------------------ BottomBar Widget ------------------
class LoginBottomBar extends StatelessWidget {
  const LoginBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double greenExtra = 20; // green wave extends lower

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4 + greenExtra,
      child: Stack(
        children: [
          // Green wave below
          ClipPath(
            clipper: WaveClipper(extraHeight: greenExtra),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFFD6ECE0), // soft green
            ),
          ),

          // Blue wave on top
          ClipPath(
            clipper: const WaveClipper(extraHeight: 0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFF3F5AA9), // bold blue
            ),
          ),

          // Optional: Add widgets above waves
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                'Welcome!',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
