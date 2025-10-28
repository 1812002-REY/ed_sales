import 'package:ed_sales/screens/softnet_login_page.dart';
import 'package:flutter/material.dart';
// page yako kuu baada ya splash

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // delay ya sekunde 3 kabla ya kuingia home page
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SoftNetLoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // rangi ya background
      body: Center(
        child: Image.asset(
          'assets/pos.png',
          width: 200, // size ya image
        ),
      ),
    );
  }
}
