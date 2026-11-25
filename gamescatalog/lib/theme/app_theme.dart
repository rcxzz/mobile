import 'package:material_ui/material_ui.dart';

class AppAssets {
  static const String background = 'assets/image/fundo.png';
  static const String logo = 'assets/image/logo.png';
}

class AppColors {
  static const Color backgroundDark = Color(0xFF0E131F);
  static const Color cardSurface = Color(0xE61A2234);
  static const Color inputFill = Color(0xFF263147);
  static const Color accentPrimary = Color(0xFF3B82F6);
  static const Color accentSecondary = Color(0xFF60A5FA);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB0B8C8);
  static const Color danger = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Monomaniac One',
      scaffoldBackgroundColor: AppColors.backgroundDark,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFill,
        errorStyle: const TextStyle(
          color: Color(0xFFFF8A80),
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: AppColors.accentPrimary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: AppColors.danger,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}