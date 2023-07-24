import 'package:flutter/material.dart';

const ColorScheme myColorScheme = ColorScheme(
  primary: Color(0xFF39311D), // Blue
  secondary: Color(0xFF7E7474), // Orange
  surface: Color(0xFFC4B6B6), // White
  background: Color(0xFFFFDD93), // Light gray
  error: Color(0xFFE57373), // Error color, in case of validation issues, etc.
  onPrimary: Color(0xFFFFFFFF), // Text color on primary color
  onSecondary: Color(0xFF000000), // Text color on secondary color
  onSurface: Color(0xFF000000), // Text color on surface color
  onBackground: Color(0xFF000000), // Text color on background color
  onError: Color(0xFF000000), // Text color on error color
  brightness: Brightness.light, // Choose between light or dark theme
);
