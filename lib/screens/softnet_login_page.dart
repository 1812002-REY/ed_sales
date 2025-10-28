import 'package:ed_sales/constants.dart';
import 'package:ed_sales/widgets/login_bottom_bar.dart';
import 'package:ed_sales/widgets/sale_efd_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../services/controller/login_controller.dart' show LoginController;
import '../services/repository/login_service.dart';
import '../widgets/login_top_bar.dart';
import 'dashboard_screen.dart';

class SoftNetLoginPage extends StatefulWidget {
  const SoftNetLoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SoftNetLoginPageState createState() => _SoftNetLoginPageState();
}

class _SoftNetLoginPageState extends State<SoftNetLoginPage> {
  final LoginController controller = Get.put(LoginController(LoginService()));

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiStyle,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.height),
            child: SafeArea(
              child: Column(
                children: [
                  Stack(
                    children: [ 
                      LoginTopBar(),
                      // ClipPath(
                      //   clipper: WaveClipper(),
                      //   child: Container(
                      //     // padding: const EdgeInsets.only(bottom: 30),
                      //     color: appColor,
                      //     height: 150,
                      //   ),
                      // ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo Section
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              // Replace the placeholder icon with your actual logo
                              Container(
                                width: 220,
                                height: 150,
                                margin: EdgeInsets.only(bottom: 16),
                                child: Image.asset(
                                  'assets/softnet_logo.png', // Your logo here
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Login Form
                        Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              // Username Field
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: TextFormField(
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Username',
                                    hintStyle: TextStyle(fontSize: 16),
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: iconTextColor,
                                    ),
                                    filled: true,
                                    fillColor: inputFieldColor.withOpacity(0.1),
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
                                child: Obx(() {
                                  return TextFormField(
                                    controller: _passwordController,
                                    obscureText: !controller.showPassword,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Password',
                                      hintStyle: TextStyle(fontSize: 16),
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: iconTextColor,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          controller.togglePasswordVisibility();
                                        },
                                        icon: Icon(
                                          controller.showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: iconTextColor,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: inputFieldColor.withOpacity(
                                        0.1,
                                      ),
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
                                  );
                                }),
                              ),

                              // Login Button
                              SizedBox(
                                width: double.infinity,
                                // height: 54,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_usernameController.text
                                            .trim()
                                            .isEmpty ||
                                        _passwordController.text
                                            .trim()
                                            .isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Please enter both username and password',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.headlineMedium,
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return; // stop here if validation fails
                                    }

                                    final username = _usernameController.text
                                        .trim();
                                    final password = _passwordController.text
                                        .trim();
                                    await controller.login(username, password);
                                    debugPrint(
                                      'Login Data: ${controller.loginData}, errorMessage: ${controller.errorMessage}',
                                    );
                                    if (controller.errorMessage.isEmpty &&
                                        controller.loginData.isNotEmpty) {
                                      // Successful login
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Login Successful!',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.headlineMedium,
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DashboardScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    } else if (controller
                                        .errorMessage
                                        .isNotEmpty) {
                                      // Show error message
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            controller.errorMessage.value,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.headlineMedium,
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: appColor,
                                    foregroundColor: buttonTextColor,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Obx(() {
                                    if (controller.isLoading.value) {
                                      return CircularProgressIndicator();
                                    }
                                    return Text(
                                      'Login',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(color: Colors.white),
                                    );
                                  }),
                                ),
                              ),
                              SizedBox(height: 20),
                              Obx(() {
                                return controller.errorMessage.isNotEmpty
                                    ? Text(
                                        controller.errorMessage.value,
                                        style: TextStyle(color: Colors.red),
                                      )
                                    : SizedBox.shrink();
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 250, child: LoginBottomBar()),
                ],
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
