import 'package:flutter/material.dart';

class SaleTopBar extends StatelessWidget {
  const SaleTopBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background wave
        ClipPath(
          clipper: WaveClipper(),
          child: Container(height: 200, color: Colors.blueGrey),
        ),
        // Content: Image + Texts
        Positioned(
          left: 20,
          top: 60,
          child: Row(
            children: [
              // Circle Avatar with Asset Image
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    "assets/pos.png", // <-- change to your image path
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Text(
                title, // Updated text
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Custom wave clipper
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 50);
    var secondControlPoint = Offset(3 * size.width / 4, size.height - 100);
    var secondEndPoint = Offset(size.width, size.height - 50);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
