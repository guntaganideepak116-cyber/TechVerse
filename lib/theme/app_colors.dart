import 'package:flutter/material.dart';

class AppColors {
  // Light Theme
  static const primaryLight = Color(0xFF259B8C); // HSL(174, 62%, 38%)
  static const accentLight = Color(0xFF30A373); // HSL(152, 55%, 42%)
  static const backgroundLight = Color(0xFFF6F8F8); // HSL(180, 10%, 97%)
  static const foregroundLight = Color(0xFF1E2629); // HSL(200, 20%, 12%)
  static const cardLight = Colors.white;
  static const borderLight = Color(0xFFE0E5E7);
  static const mutedForegroundLight = Color(0xFF6A7A80);
  static const secondaryLight = Color(0xFFECF4F2);

  // Dark Theme
  static const primaryDark = Color(0xFF2BBFAE); // HSL(174, 62%, 45%)
  static const accentDark = Color(0xFF32B378); // HSL(152, 55%, 45%)
  static const backgroundDark = Color(0xFF0A0F12); // HSL(200, 20%, 8%)
  static const foregroundDark = Color(0xFFEBF1F2); // HSL(180, 10%, 92%)
  static const cardDark = Color(0xFF181F24); // HSL(200, 18%, 12%)
  static const borderDark = Color(0xFF283238);
  static const mutedForegroundDark = Color(0xFF7DA3B2);
  static const secondaryDark = Color(0xFF232D33);

  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, accentLight],
  );

  static const heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, Color(0xFF40BFBF), accentLight],
  );

  static List<BoxShadow> cardShadow(bool isDark) => [
    BoxShadow(
      color: isDark ? Colors.black.withOpacity(0.3) : const Color(0xFF1E2629).withOpacity(0.08),
      blurRadius: 16,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> cardShadowHover(bool isDark) => [
    BoxShadow(
      color: primaryLight.withOpacity(isDark ? 0.25 : 0.18),
      blurRadius: 30,
      offset: const Offset(0, 8),
    ),
  ];
}
