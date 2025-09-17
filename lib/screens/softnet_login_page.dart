import 'package:flutter/material.dart';
import '../widgets/curved_background_painter.dart';
import 'dashboard_screen.dart';

class SoftNetLoginPage extends StatefulWidget {
  @override
  _SoftNetLoginPageState createState() => _SoftNetLoginPageState();
}

class _SoftNetLoginPageState extends State<SoftNetLoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF4A90E2), Color(0xFF2E5BBA)],
            ),
          ),
          child: CustomPaint(
            painter: CurvedBackgroundPainter(),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Section
                    Container(
                      margin: EdgeInsets.only(bottom: 60),
                      child: Column(
                        children: [
                          // Replace the placeholder icon with your actual logo
                          Container(
                            width: 120,
                            height: 120,
                            margin: EdgeInsets.only(bottom: 16),
                            child: Image.asset(
                              'assets/softnet_logo.png', // Your logo here
                              fit: BoxFit.contain,
                            ),
                          ),
                          // SoftNet text
                          // RichText(
                          //   text: TextSpan(
                          //     children: [
                          //       TextSpan(
                          //         text: 'Soft',
                          //         style: TextStyle(
                          //           fontSize: 32,
                          //           fontWeight: FontWeight.w300,
                          //           color: Color(0xFF4CAF50),
                          //           letterSpacing: 1.5,
                          //         ),
                          //       ),
                          //       TextSpan(
                          //         text: 'Net',
                          //         style: TextStyle(
                          //           fontSize: 32,
                          //           fontWeight: FontWeight.w300,
                          //           color: Color(0xFF4CAF50),
                          //           letterSpacing: 1.5,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          // Text(
                          //   'Creativity at Work',
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //     color: Color(0xFF4CAF50),
                          //     fontStyle: FontStyle.italic,
                          //     letterSpacing: 0.5,
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    // Login Form
                    Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          // Username Field
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              controller: _usernameController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Enter Username',
                                hintStyle: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Colors.white70,
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xFF4CAF50),
                                    width: 2,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                              ),
                            ),
                          ),

                          // Password Field
                          Container(
                            margin: EdgeInsets.only(bottom: 32),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Enter Password',
                                hintStyle: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.white70,
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xFF4CAF50),
                                    width: 2,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                              ),
                            ),
                          ),

                          // Login Button
                          Container(
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton(
                              onPressed: () {
                                print('Username: ${_usernameController.text}');
                                print('Password: ${_passwordController.text}');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF64B5F6),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
