import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokedexTheme {
  static ThemeData get mixed => ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        textTheme: GoogleFonts.quicksandTextTheme(),
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.blue.shade700,
          onPrimary: Colors.white,
          secondary: Colors.yellow.shade700,
          onSecondary: Colors.black,
          error: Colors.red.shade400,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black87,
        ),
        scaffoldBackgroundColor: Colors.blue.shade50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.yellow.shade600,
          elevation: 4,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
          ),
          titleTextStyle: GoogleFonts.quicksand(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.yellow.shade600,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.blue.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.red.shade400, width: 2),
          ),
          prefixIconColor: Colors.blue.shade400,
        ),

        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 6,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          color: Colors.white,
          shadowColor: Colors.blue.shade200.withValues(alpha: 0.4),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.blue.shade100,
          selectedColor: Colors.yellow.shade700,
          labelStyle: GoogleFonts.quicksand(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade500,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            textStyle: GoogleFonts.quicksand(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      );
}
