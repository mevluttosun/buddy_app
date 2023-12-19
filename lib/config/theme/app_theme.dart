import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  useMaterial3: true,
  primaryColor: const Color(0xFF0055D3),
  dividerColor: const Color(0xFFD1D1D6),
  hintColor: const Color(0xFFC7C7CC),
  fontFamily: 'GalanoGrotesque',
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
    ),
  ),
);
const kShortAnimationDuration = Duration(milliseconds: 300);
const kLongAnimationDuration = Duration(milliseconds: 600);
const kDefaultPaddingValue = 16.0;
const kDefaultBorderRadiusValue = 8.0;
