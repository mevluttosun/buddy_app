import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
    useMaterial3: true,
    primaryColor: const Color(0xFF0055D3),
    fontFamily: 'GalanoGrotesque',
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ));
const kShortAnimationDuration = Duration(milliseconds: 300);
const kLongAnimationDuration = Duration(milliseconds: 600);
