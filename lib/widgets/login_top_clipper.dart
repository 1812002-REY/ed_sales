import 'package:flutter/material.dart';

import 'home_top_bar.dart';

class LoginTopBar extends StatelessWidget {
  const LoginTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background wave
        ClipPath(
          clipper: WaveClipper(),
          child: Container(height: 200, color: Colors.blue),
        ),
        // Content: Image + Texts
     
      ],
    );
  }
}

// Custom wave clipper

