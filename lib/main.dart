import 'package:ed_sales/constants.dart';
import 'package:ed_sales/screens/softnet_login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'services/utils.dart';

void main() {
  // AppUtils.decryptUrls();
  runApp(ed_sales());
}

class ed_sales extends StatelessWidget {
  const ed_sales({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SoftNet Login',
      home: SoftNetLoginPage(),
      theme: appTheme,
      // home: TestScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
