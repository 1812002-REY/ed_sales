import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final Color inputFieldColor = Color(0xFFF5D8CF);
final Color iconTextColor = Color(0xFF4A2A20);
final Color appColor = Color(0xFF1976D2);
final Color buttonTextColor = Colors.white;
final Color lightBlue = Colors.lightBlue[100]!;
final Color awesomeGrey = Colors.grey[200]!;

final systemUiStyle = SystemUiOverlayStyle(
        statusBarColor: appColor, // your color
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      );



final ThemeData appTheme = ThemeData(
  primaryColor: appColor,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Roboto', // clean & professional
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black), // Big titles
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87), // Section titles
    titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87), // Form titles, headings
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black87), // Main body text
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black54), // Secondary text
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white), // Buttons
    labelMedium: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.grey), // Hints, captions
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: appColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),
);