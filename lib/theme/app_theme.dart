import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF7A9EAF);
  static const Color accentPink = Color(0xFFD4A5B0);
  static const Color darkGrey = Color(0xFF2D2D2D);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color redAccent = Color(0xFF8B3A3A);
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primaryBlue,
        secondary: accentPink,
        surface: white,
        error: redAccent,
      ),
      scaffoldBackgroundColor: lightGrey,

      appBarTheme: AppBarTheme(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: black),
        titleTextStyle: TextStyle(
          color: black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: black,
          foregroundColor: white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(vertical: 16),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: black,
          side: BorderSide(color: black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
      ),

      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: black,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: darkGrey),
        bodyMedium: TextStyle(fontSize: 14, color: darkGrey),
      ),
    );
  }
}
