import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData myTheme = ThemeData(
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: const Color(0xFF1565C0), 
    ),
  ),
  
  primarySwatch: const MaterialColor(
    0xFF1565C0, // Azul principal
    {
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(0xFF2196F3),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0), // Color principal
      900: Color(0xFF0D47A1),
    },
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: const MaterialColor(
      0xFF1565C0, // Azul principal
      {
        50: Color(0xFFE3F2FD),
        100: Color(0xFFBBDEFB),
        200: Color(0xFF90CAF9),
        300: Color(0xFF64B5F6),
        400: Color(0xFF42A5F5),
        500: Color(0xFF2196F3),
        600: Color(0xFF1E88E5),
        700: Color(0xFF1976D2),
        800: Color(0xFF1565C0), // Color principal
        900: Color(0xFF0D47A1),
      },
    ),
  ).copyWith(
    secondary: const Color(0xFFFF6F00), // Naranja secundario
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: Colors.grey[200], // Fondo gris claro para mejor contraste
  textTheme: GoogleFonts.montserratTextTheme(
    Typography.material2018(platform: TargetPlatform.android).white,
  ).copyWith(
    headlineLarge: TextStyle(
      fontSize: 34,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.bold,
      color: Color(0xFF1565C0), // Usa el azul principal
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 20,
      fontFamily: "Montserrat",
      color: Colors.black87,
    ),
  ).apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    color: Color(0xFF1565C0), // Azul principal
    elevation: 2,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFFF6F00), // Naranja secundario
  ),
);
