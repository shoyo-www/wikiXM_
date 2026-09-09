import 'package:flutter/material.dart';
import 'sports_theme.dart';

extension SportsThemeContext on BuildContext {
  SportsTheme get sports {
    return Theme.of(this).extension<SportsTheme>()!;
  }
}

Color getAvatarColor(int index) {
  const colors = [
    Color(0xFFDFF3E4),
    Color(0xFFFFE5D9),
    Color(0xFFE2E8F9),
    Color(0xFFFFF1C7),
    Color(0xFFE8DFF5),
    Color(0xFFDDF4F0),
    Color(0xFFF9DDE8),
    Color(0xFFE5E5E5),
  ];

  return colors[index % colors.length];
}