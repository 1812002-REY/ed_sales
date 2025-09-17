import 'package:flutter/material.dart';
import 'screens/softnet_login_page.dart';
import 'screens/test.dart';


void main() {
runApp(ed_sales());
}


class ed_sales extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'SoftNet Login',
theme: ThemeData(
primarySwatch: Colors.blue,
fontFamily: 'Roboto',
),
home: SoftNetLoginPage(),
// home: TestScreen(),
debugShowCheckedModeBanner: false,
);
}
}