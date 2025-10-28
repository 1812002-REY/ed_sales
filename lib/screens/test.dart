import 'package:flutter/material.dart';

import '../widgets/top_bottom_curve.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return
    //  Scaffold(
    //   body: CustomPaint(
    //     painter: WavePainter(),
    //     child: SizedBox(height: 300, width: double.infinity),
    //   ),
    // );
    Scaffold(
      body: Stack(
        children: [
          // Top Wave
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              painter: TopWavePainter(),
              child: Container(height: 180),
            ),
          ),

          // Bottom Wave
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              painter: BottomWavePainter(),
              child: Container(height: 180),
            ),
          ),

          // Center content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.flutter_dash, size: 80, color: Colors.blue.shade900),
                SizedBox(height: 20),
                Text(
                  "Wave Layout Example",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ElevatedButton(onPressed: () {}, child: Text("Get Started")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
