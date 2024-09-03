import 'package:flutter/material.dart';

class AppTheme {
  static const Color lightGray = Color(0xFFF0F0F0);
  static const Color darkGray = Color(0xFFCCCCCC);

  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color(0xFFF5BFC0),
      primary: const Color(0xFFF5BFC0),
    ),
    useMaterial3: true,
  );
}
