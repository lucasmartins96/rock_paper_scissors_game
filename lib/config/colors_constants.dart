import 'package:flutter/material.dart';

class ColorsConstants {
  static const darkText = Color(0xFF3B4363);
  static const scoreText = Color(0xFF2A46C0);
  static const headerOutline = Color(0xFF606E85);
  static final gradient = GradientColors();
}

class GradientColors {
  BackgroundColors get background => BackgroundColors();
  ScissorsColors get scissors => ScissorsColors();
  PaperColors get paper => PaperColors();
  RockColors get rock => RockColors();
}

class BackgroundColors {
  static final Map<int, Color> _shades = {
    800: const Color(0xFF1F3756),
    900: const Color(0xFF141539),
  };

  static final customColor = MaterialColor(0xFFECA922, _shades);
}

class ScissorsColors {
  static final Map<int, Color> _shades = {
    400: const Color(0xFFECA922),
    500: const Color(0xFFEC9E0E),
  };

  static final customColor = MaterialColor(0xFFECA922, _shades);
}

class PaperColors {
  static final Map<int, Color> _shades = {
    300: const Color(0xFF5671F5),
    400: const Color(0xFF4865F4),
  };

  static final customColor = MaterialColor(0xFFECA922, _shades);
}

class RockColors {
  static final Map<int, Color> _shades = {
    400: const Color(0xFFDD405D),
    500: const Color(0xFFDC2E4E),
  };

  static final customColor = MaterialColor(0xFFECA922, _shades);
}
