import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color(0xFFDBCC95),
  ),
  textTheme: GoogleFonts.montserratTextTheme().copyWith(
    bodySmall: TextStyle(fontSize: 18),
  ),
  dividerTheme: DividerThemeData(color: Colors.black.withOpacity(.1)),
);
