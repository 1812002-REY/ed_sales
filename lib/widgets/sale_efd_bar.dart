import 'package:flutter/material.dart';

import 'home_top_bar.dart';

class SaleEfdTopBar extends StatelessWidget {
  final String serialNumber;
  const SaleEfdTopBar({super.key, required this.serialNumber});

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
                serialNumber, // Updated text
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

