import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData learnWidget = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.red,
  ),
  fontFamily: GoogleFonts.openSans().fontFamily,
  textTheme: const TextTheme(
      bodySmall: TextStyle(fontSize: 12),
      bodyLarge: TextStyle(fontSize: 24),
      bodyMedium: TextStyle(fontSize: 20)),
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.blue[100],
);
