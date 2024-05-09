import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color(0XFF010101),
    primary: Color(0XFF998EFE),
    secondary: Color(0xFF20202E),
  ),
  textTheme: const TextTheme(
    displayLarge:
        TextStyle(color: Color(0xFFFFFFFF), fontFamily: 'SFProDisplay'),
    displayMedium:
        TextStyle(color: Color(0xFFE7E7E7), fontFamily: 'SFProDisplay'),
    displaySmall:
        TextStyle(color: Color(0xFFE7E7E7), fontFamily: 'SFProDisplay'),
  ),
);
