import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light() => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        textTheme: GoogleFonts.funnelDisplayTextTheme(),
        fontFamily: GoogleFonts.funnelDisplay().fontFamily,
        fontFamilyFallback: const ['Amstelvar'],
      );
}
